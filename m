Date: Thu, 13 Jul 2000 11:23:31 -0700
Subject: Re: Xfree 4.0.1 dual head attempt
From: "W. Taylor Holliday" <wtholliday@ucdavis.edu>
To: <daenzerm@student.ethz.ch>
CC: Linux PPC Developer List <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B5935733.2DB%wtholliday@ucdavis.edu>
In-Reply-To: <396DB817.4C2D82F1@relog.ch>
Mime-version: 1.0
Content-type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> From: Michel Dänzer <daenzer@relog.ch>
> A gdb backtrace mey be interesting, at least with a static server.

Well, I'm not all that familiar with debugging this low level stuff. When I
tried running the X server within gdb, the whole system crashed. I suppose I
need to figure out how to enable debug options and recompile.

>> (==) ServerLayout "DualHead"
>> (**) |-->Screen "Screen0" (0)
>> (**) |   |-->Monitor "Monitor0"
>> (**) |   |-->Device "r128"
>> (**) |-->Screen "Screen1" (1)
>> (**) |   |-->Monitor "Monitor0"
>> (**) |   |-->Device "r128.1"
>
> You are using the same Monitor for both Screens. Have you tried using
> different ones? (All in terms of XF86Config ;)
>
>
> Michel
>

The XF4 docs say that sharing the monitor def is ok. Still, I will separate
the defs and try again.

- Taylor


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
