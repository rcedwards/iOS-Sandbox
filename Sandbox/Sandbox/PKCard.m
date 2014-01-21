//
//  PKCard.m
//  ObjCTesting
//
//  Created by Robert Edwards on 12/3/13.
//  Copyright (c) 2013 Robert Edwards. All rights reserved.
//

#import "PKCard.h"

@implementation PKCard

- (id)initWithSuit:(PKCardSuit)suit rank:(PKCardRank)rank {
	if (self = [super init]) {
		_suit = suit;
		_rank = rank;
	}
	return self;
}

- (NSString *)description {
	NSString *rankName = [self stringFromRank:self.rank];
	NSString *suitName = [self stringFromSuit:self.suit];
	return [NSString stringWithFormat:@"%@ of %@", rankName, suitName];
}

- (NSString *)stringFromSuit:(PKCardSuit)suit {
	NSString *suitString = nil;
	switch (suit) {
		case PKCardSuitSpade:
			suitString = @"Spades";
			break;
		case PKCardSuitHeart:
			suitString = @"Hearts";
			break;
		case PKCardSuitClub:
			suitString = @"Clubs";
			break;
		case PKCardSuitDiamond:
			suitString = @"Diamonds";
			break;
	}
	return suitString;
}

- (NSString *)stringFromRank:(PKCardRank)rank {
	NSString *rankString = nil;
	switch (rank) {
		case PKCardRankAce:
			rankString = @"Ace";
			break;
		case PKCardRankKing:
			rankString = @"King";
			break;
		case PKCardRankQueen:
			rankString = @"Queen";
			break;
		case PKCardRankJack:
			rankString = @"Jack";
			break;
		default:
			rankString = [NSString stringWithFormat:@"%u", rank+1];
			break;
	}
	return rankString;
}

@end
