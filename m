Date: Wed, 16 Dec 1998 11:53:39 -0600
From: Joshua Rosenau <jrosenau@midway.uchicago.edu>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: Restructure of arch/ppc/kernel and include/asm-ppc
Message-ID: <19981216115339.S1037@midway.uchicago.edu>
References: <Pine.LNX.4.02.9812131538310.871-100000@cassiopeia.home> <19981214105418.022383@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <19981214105418.022383@mail.mipsys.com>; from Benjamin Herrenschmidt on Mon, Dec 14, 1998 at 10:54:18AM +0100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


So on Mon, Dec 14, 1998 at 10:54:18AM +0100, Benjamin Herrenschmidt was all like,

>
>On Sun, Dec 13, 1998, Geert Uytterhoeven <geert@geert.cs.kuleuven.ac.be>
>wrote:
>
>This could be a good idea since it would fix a big outstanding issue: The
>inability of MacOS VM to lock contiguously enough space for the kernel
>and ramdisk in lots of cases (the -622 error most people with virtual
>memory ON are experiencing). If the booter was itself a nini-kernel that
>takes care of further loading of the real kernel and ramdisk, this issue
>would probably disappear.

Would this also make it possible for linuxppc to support machines without
OF?  Currently MkLinux does a similar maneuver and I wonder if this
minikernel could replace the Mach Kernel and just catch whatever data
gets sent from the MkLinux Booter about video settings etc.  Dunno how
linuxppc loads really, so this may be silly.  

Josh

[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
