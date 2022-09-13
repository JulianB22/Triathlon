This study explores how machine learning methods can be applied to triathlon race data in order to
forecast the performance of the running and cycling segments. These predictions aim to assist
triathletes with pacing guidance mid-race so that, after they finish the swimming heat, they can be
advised as to what the optimum cycling and running pace would be if they are to achieve their
overall target time.

Twenty years’ worth of elite-level triathlon performances over both sprint and Olympic-distances are
used to train neural network, linear regression and regression tree algorithms. The weak correlation
between running times and the independent variables results in a clear gulf in accuracy between
when running is treated as the target variable, to when cycling is the target variable. All three
models appear equally applicable to each of the four performance groups - Olympic Male, Olympic
Female, Sprint Male and Sprint Female as there is very little difference in accuracy scores. The
artificial neural network model generates slightly more accurate predictions and, whilst it lacks
transparency, is sensitive to all three independent variables and their relative explanatory power
over the dependent variables. Regression trees, on the other hand, are easier to understand but,
particularly when pruned, lose a sizeable portion of the accuracy as their predictions become too
generalised.

Therefore, the real-world application of these models would use neural networks to predict a cycling
time and then deduct this value, the transition and swimming times by the overall target time in
order to produce the optimal pacing guides for the final two segments. When there is minimal
variation in training data, particularly around racing conditions and athlete physiological profiles, the
model works most effectively and offers relevant tactical guidance to enhance performance mid-
race.
