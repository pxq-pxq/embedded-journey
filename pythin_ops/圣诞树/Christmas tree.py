#! /usr/bin/python3

star='*'
star_count=1
spces_count=5
spces_count2=3
spces_count3=4
star_count3=3
star_count2=5
for i in range(0,5):
    for t in range(spces_count):
        print(' ',end='')
    for f in range(star_count):
        print(star,end='')
    spces_count-=1
    star_count+=2
    print('\n')
for g in range(0,3):
    for h in range(spces_count2):
        print(' ',end='')
    for j in range(star_count2):
        print(star,end='')
    spces_count2-=1
    star_count2+=2
    print('\n')
for k in range(0,3):
    for l in range(spces_count3):
        print(' ',end='')
    for n in range(star_count3):
        print(star,end='')
    print('\n')
