From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Reply-To: khendricks@ivey.uwo.ca
To: Giovanna Ambrosini <ambrosini@lightning.ch>
Subject: Re: patch: POSIX.1b signals for ppc
Date: Wed, 26 Apr 2000 13:11:21 -0400
Content-Type: text/plain
Cc: linuxppc-dev@lists.linuxppc.org
References: <v03110700b52c8481fb7e@[209.183.131.177]> <v03110700b52cb98e15b9@[129.100.29.243]>
In-Reply-To: <v03110700b52cb98e15b9@[129.100.29.243]>
MIME-Version: 1.0
Message-Id: <00042613142600.25418@khendricks_mac>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Giovanna,

> I need to keep using a stable kernel so I have attempted to backport your
> POSIX.1b.patch back to Paul's latest 2.2.15pre19 kernel.
>
> Here is the patch.  It compiles cleanly but I have not attempted to boot
> with it yet (but will soon).
>
> If this works, I would like to get your changes into both Paul's stable and
> devel trees as soon as possible.  This functionality has been in the x86
> kernel since at least the beginning of the 2.2 kernel series.

I have just finished running jdk 1.3 successfully using Paul's stable
2.2.15pre19 kernel (rsynced yesterday) and your posix signal patch backported
to the stable tree.

So far it seems to be working well with no real difficulties.

I will try to exercise the SA_SIGINFO info in some signal handlers to make sure
things are working okay.

I sure hope Paul and Cort add your patch in.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
