Message-ID: <39AF028E.1C024B66@wanadoo.fr>
Date: Fri, 01 Sep 2000 03:12:46 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <bh40@calva.net>
CC: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: 2.4 problems
References: <39AEC1C7.E0894CFB@wanadoo.fr> <20000831214724.8428@192.168.1.10>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:
>
> >On my 6400, both bk-test8 and pmac-devel-test7 are running nicely. The
> >one major problem is random sudden freezes that can happen after some
> >minutes or after 3 days and which have been reported a couple of times
> >by others, too. It is like the ADB interrupt dies. There are no
> >messages, the computer is still alive, it goes on compiling or
> >downloading, and today I even could ssh in over the net, but locally,
> >keyboard and mouse are dead, even MagicSysRq, the only working key combo
> >is ctrl-cmd-power :-(
> >
> >I never saw this with 2.2.X kernels (not recently, in any case).
>
> Interesting. Do you have the new input layer enabled or are you still
> running the old keyboard and mouse drivers ?

I am now running the new input layer (with old keycodes). But I saw
(rather, suffered from) these freezes already before the arrival of the
new input layer. For a while I blamed it on Xpmac, where I seem to
remember having had these even with 2.2.x kernels, but I am using now
XFree-4.0.1-fbdev.

>                                              If you telnet to the box, do
> you still see ADB interrupts increasing when typing keys or not ?

You mean when I type on the local "dead" keyboard? I couldn't test this
yet, because the machine from which I sshed in was 15 km away at work.
And after a while I had the bad idea to type "hwclock -r", upon which
the 6400 was really dead, so I could not test it any further. While I
observed it, the ADB interrupt did not increase.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
