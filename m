Date: Tue, 15 Aug 2000 13:12:58 -0700 (PDT)
From: William Blew <wblew@home.com>
To: Dave Wolfe <dwolfe@lists.linuxppc.org>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: drand48() broken?
In-Reply-To: <20000815104522.B11780@lists.linuxppc.org>
Message-ID: <Pine.LNX.4.10.10008151301340.12763-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, 15 Aug 2000, Dave Wolfe wrote:

> Is my PPC installation just too old and drand48() (actually it's
> probably srand48() that's broken) is fixed now? To see what your Perl
> uses, enter `perl -V:randfunc' (just `perl -V' gives you the version of
> Perl). If it says `drand48', try this:
>
>     while true;do perl -e 'print int rand(62), " "';done
>
> (Hit ^C to stop it) then let's compare versions of the various parts.

I am using YDL champion server 1.2 on a beige G/3266 Power Macintosh

 kernel: 2.2.17-0.6.1               (the latest kernel from YDL)
    gcc: version 2.95.2, release 1i ( from champion server 1.2 )
  glibc: version 2.1.3,  release 5a ( from champion server 1.2 )

perl 5.6.0, release 1 ( built from the SRPM )

perl -V:randfunc yields randfunc='drand48';

[root@artemis /tmp]# while true;do perl -e 'print int rand(62), " "';done
61 32 24 11 34 21 42 18 9 59 10 41 44 27 37 2 44 9 47 3 34 42 51 7 40 0
46 26 21 24 38 61 48 33 17 24 24 52 2 28 45 15 31 50 17 4 47 23 21 26 45
33 38 15 10 44 4 27 37 8 13 16 18 32 10 20 17 20 36 48 58 28 12 26 34 37
36 44 9 56 20 30 45 45 11 37 33 10 28 60 5 48 4 33 55 48 11 3 47 51 20 49
21 55 31 56 61 61 43 55 39 7 21 52 54 11 7 61 3 42 34 10 20 22 13 54 24 2
27 20 11 20 2 4 5 17 33 22 20 18 10 61 3 60 27 16 39 3 0 2 3 53 35 43 53
27 37 32 7 1 28 57 15 17 25 9 33 42 55 32 32 33 27 14 11 2 12 28 34 15 56
1 48 51 6 39 6 34 13 6 41 48 51 8 6 52 52 0 56 20 47 7 12 47 59 15 16 10
26 61 25 47 8 56 13 38 10 61 14 46 35 12 47 59 38 59 61 0 33 35 52 35 12
2 61 51 0 9 6 1 24 60 56 4 5 53 40 5 34 52 9 57 11 14 7 53 39 12 0 36 5
15 30 59 33 24 24 37 40 2 25 39 16 54 6 12 29 38 24 33 52 61 7 4 22 58 1
56 34 14 10 51 9 35 12 38 36 38 19 47 38 0 42 56 2 18 5 26 27 40 35 22 22
1 41 4 3 37 41 3 18 30 21 18 31 30 42 49 6 61 0 46 17 36 60 50 34 1 43 61
15 6 10 16 0 53 24 46 15 20 33 59 58 54 31 61 42 61 36 28 40 49 4 29 22 30
13 30 27 52 6 58 8 52 9 40 38 26 50 50 12 2 39 46 38 17 27 48 58 44 43 45
3 1 14 57 3 61 20 56 61 57 36 1 46 43 44 5 6 44 19 48 28 31 39 25 27 43 39
38 36 5 12 33 57 22 26 23 8 30 37 49 17 29 9 43 30 35 44 24 22 36 6 52 15
43 40 8 26 15 51 12 0 17 0 24 55 58 54 38 30 47 53 24 16 1 13 28 41 26 50
41 49 43 21 45 3 49 15 51 50 25 15 14 11 6 5 38 41 48 26 60 15 11 17 11 16
43 33 48 28 1 37 33 52 8 15 50 16 43 54 20 45 5 35 26 48 16 1 11 40 19 56
27 3 11 59

Is this different from your results? Should I re-compile my perl install?
---
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
