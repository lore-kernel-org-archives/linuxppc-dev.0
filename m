Mime-Version: 1.0
Message-Id: <v04220802b5b2e2274457@[10.0.0.42]>
In-Reply-To: 
 <Pine.LNX.3.96LJ1.1b7.1000806003715.14804A-100000@ofey.earthlink.net>
References: 
 <Pine.LNX.3.96LJ1.1b7.1000806003715.14804A-100000@ofey.earthlink.net>
Date: Sun, 6 Aug 2000 02:45:37 -0700
To: Takashi Oe <toe@unlserve.unl.edu>
From: "Timothy A. Seufert" <tas@mindspring.com>
Subject: Re: a GCC question
Cc: linuxppc-dev@lists.linuxppc.org
Content-Type: text/plain; charset="us-ascii" ; format="flowed"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 1:01 AM -0500 8/6/00, Takashi Oe wrote:

>By the way, has anyone noticed compiling arch/ppc/mm/init.c takes very
>long time?  On my machine, it takes as long as about two minutes to just
>compile it, while compiling other files are almost instantaneous.  Well,
>it's one of the biggest C files, but, still, I wonder if we can organize
>the code a bit to help the compiler somehow.  Perhaps, my machine is too
>slow?

Something odd is going on.  2 minutes is way too long.  I just did:

rm arch/ppc/mm/init.o
make

on a 2.2.17pre13 tree which was otherwise fully compiled and watched
for make to start compiling init.c.  It took less than a second to
compile.

My computer is very fast, but it can't be that much faster than
yours!  Perhaps you are consistently hitting some VM thrashing at
that point in a full kernel build?

   Tim Seufert

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
