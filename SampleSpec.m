#define EXP_SHORTHAND

#import "Specta.h"
#import "Expecta.h"

SpecBegin(MathSpec)

describe(@"Math", ^{
    it(@"is pretty cool", ^{
        NSUInteger a = 16;
        NSUInteger b = 26;
        expect(a + b).to.equal(42);
    });
});

SpecEnd
