%Initialize friend lists for every man
initFriends([], _).
initFriends([X | T], L):- sublist(X, L), initFriends(T, L).
 
%Construct friends list for surname
surnameFriends(S, [S | _], [SF | _], SF).
surnameFriends(X, [_ | Y], [_ | Z], SF):- surnameFriends(X , Y, Z, SF).

solve([[Leonid, leonid, LeonidFriends],[Michael, michael, MichaelFriends],[Nickolay, nickolay, NickolayFriends],[Oleg, oleg, OlegFriends],[Peter, peter, PeterFriends]]):-
        
         permutation([atarov, bartenev, klenov, danilin, ivanov],
                    [Leonid, Michael, Nickolay, Oleg, Peter]),
       
         data([
               [Leonid, leonid, LeonidFriends],
               [Michael, michael, MichaelFriends],
               [Nickolay, nickolay, NickolayFriends],
               [Oleg, oleg, OlegFriends],
               [Peter, peter, PeterFriends]
              ]), !.

data([
      [Leonid, leonid, LeonidFriends],
      [Michael, michael, MichaelFriends],
      [Nickolay, nickolay, NickolayFriends],
      [Oleg, oleg, OlegFriends],
      [Peter, peter, PeterFriends]
     ]):- 
        
        %They know each other, so...
        Nickolay \= ivanov,
        Michael \= danilin,
        
        initFriends([LeonidFriends, MichaelFriends, NickolayFriends, OlegFriends, PeterFriends],
                   [[Leonid, leonid], [Michael, michael], [Nickolay, nickolay], [Oleg, oleg], [Peter, petr]]),
        
        %Peter knows 3 men
        PeterFriends = [_, _, _],

        %Leonid knows 1 man
        LeonidFriends = [_],

        %Leonid knows only 1 man, so only 1 man knows Leonid(if-else-elseif...)
        (member([Leonid, leonid], MichaelFriends),
            (\+(member([Leonid, leonid], NickolayFriends)), \+(member([Leonid, leonid], OlegFriends)), \+(member([Leonid, leonid], PeterFriends)));
            
        member([Leonid, leonid], NickolayFriends),
            (\+(member([Leonid, leonid], MichaelFriends)), \+(member([Leonid, leonid], OlegFriends)), \+(member([Leonid, leonid], PeterFriends)));
            
        member([Leonid, leonid], OlegFriends),
            (\+(member([Leonid, leonid], MichaelFriends)), \+(member([Leonid, leonid], NickolayFriends)), \+(member([Leonid, leonid], PeterFriends)));
            
        member([Leonid, leonid], PeterFriends),
            (\+(member([Leonid, leonid], MichaelFriends)), \+(member([Leonid, leonid], NickolayFriends)), \+(member([Leonid, leonid], OlegFriends)))),


        %Michael, Nickolay and Oleg know each other
        member([_, nickolay], MichaelFriends),
        member([_, oleg], MichaelFriends),

        member([_, michael], NickolayFriends),
        member([_, oleg], NickolayFriends),

        member([_, michael], OlegFriends),
        member([_, nickolay], OlegFriends),


        %Nickolay knows Ivanov
        member([ivanov, _], NickolayFriends),

        \+(member([_, leonid], LeonidFriends)),
        \+(member([_, michael], MichaelFriends)),
        \+(member([_, nickolay], NickolayFriends)),
        \+(member([_, oleg], OlegFriends)),
        \+(member([_, petr], PeterFriends)),

        %Michael doesn't know Danilin
        \+(member([danilin, _], MichaelFriends)), 

        %Bartenev knows two men
        surnameFriends(bartenev, [Leonid, Michael, Nickolay, Oleg, Peter],
                                     [LeonidFriends, MichaelFriends, NickolayFriends, OlegFriends, PeterFriends], BartenevFriends),
        BartenevFriends = [_, _],

        %Danilin doesn't know Michael
        surnameFriends(danilin, [Leonid, Michael, Nickolay, Oleg, Peter],
                                    [LeonidFriends, MichaelFriends, NickolayFriends, OlegFriends, PeterFriends], DanilinFriends),
        \+(member([_, michael], DanilinFriends)),


        %Ivanov knows Nickolay
        surnameFriends(ivanov, [Leonid, Michael, Nickolay, Oleg, Peter],
                                   [LeonidFriends, MichaelFriends, NickolayFriends, OlegFriends, PeterFriends], IvanovFriends),
        member([_, nickolay], IvanovFriends),

        %Atarov knows 3 men
        surnameFriends(atarov,[Leonid, Michael, Nickolay, Oleg, Peter],
                                  [LeonidFriends, MichaelFriends, NickolayFriends, OlegFriends, PeterFriends], AtarovFriends),
        AtarovFriends = [_, _, _].
