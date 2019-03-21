use Test::More;

my $TEMPLATE = <<'EOF';
package MyMod%d;
use Moo;
use MooX::StrictHas;
has attr => (%s);
EOF

package main;

my $pkgcount = 0;
sub test_with_attr {
  my ($attr, $expected) = @_;
  local $Test::Builder::Level = $Test::Builder::Level + 1;
  local $@;
  eval sprintf $TEMPLATE, $pkgcount++, $attr;
  like $@, $expected, "$attr";
}

test_with_attr('', qr/^$/);
test_with_attr('auto_deref => 1', qr/auto_deref/);
test_with_attr('lazy_build => 1', qr/lazy_build/);
test_with_attr('auto_deref => 1, lazy_build => 1', qr/auto_deref.*lazy_build/s);

done_testing;
