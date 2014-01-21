//
//  PKDeck.m
//  ObjCTesting
//
//  Created by Robert Edwards on 12/3/13.
//  Copyright (c) 2013 Robert Edwards. All rights reserved.
//

#import "PKDeck.h"
#import "PKCard.h"

@interface PKDeck() {
	NSMutableOrderedSet *_cards;
}

@end

@implementation PKDeck

- (id)init {
	if (self = [super init]) {
		[self populateDeck];
	}
	return self;
}

- (void)populateDeck {
	_cards = [NSMutableOrderedSet orderedSet];
	PKCardSuit currentSuit = PKCardSuitHeart;
	while (currentSuit<=PKCardSuitSpade) {
		PKCardRank currentRank = PKCardRankAce;
		while (currentRank<=PKCardRankKing) {
			PKCard *card = [[PKCard alloc] initWithSuit:currentSuit rank:currentRank];
			[_cards addObject:card];
			currentRank++;
		}
		currentSuit++;
	}
}

@end
