//
//  PKCard.h
//  ObjCTesting
//
//  Created by Robert Edwards on 12/3/13.
//  Copyright (c) 2013 Robert Edwards. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSUInteger, PKCardRank) {
	PKCardRankAce,
	PKCardRankTwo,
	PKCardRankThree,
	PKCardRankFour,
	PKCardRankFive,
	PKCardRankSix,
	PKCardRankSeven,
	PKCardRankEight,
	PKCardRankNine,
	PKCardRankTen,
	PKCardRankJack,
	PKCardRankQueen,
	PKCardRankKing
};

typedef NS_ENUM(NSUInteger, PKCardSuit) {
	PKCardSuitHeart,
	PKCardSuitDiamond,
	PKCardSuitClub,
	PKCardSuitSpade
};

@interface PKCard : NSObject

@property (nonatomic, readonly) PKCardRank rank;
@property (nonatomic, readonly) PKCardSuit suit;

- (id)initWithSuit:(PKCardSuit)suit rank:(PKCardRank)rank;

@end
