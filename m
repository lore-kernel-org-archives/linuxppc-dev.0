From: Jesper Skov <jskov@cygnus.co.uk>
Message-ID: <14091.17276.886028.400693@lassi.cygnus.co.uk>
Date: Wed, 7 Apr 1999 12:37:32 +0100 (BST)
To: bh40@calva.net
cc: Geert.Uytterhoeven@cs.kuleuven.ac.be, linuxppc-dev@lists.linuxppc.org,
        asun@saul9.u.washington.edu
Subject: Re: Resurrecting mkLinux
In-Reply-To: <Pine.LNX.4.03.9904071324330.27618-100000@mercator.cs.kuleuven.ac.be>
References: <Pine.LNX.4.03.9904071324330.27618-100000@mercator.cs.kuleuven.ac.be>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



[Thanks for forwarding it to me, Geert]

Benjamin> What is the APUS bootloader doing ? (Will it load the kernel
Benjamin> at a fixed address ?)

The problem on APUS systems is that the start address of physical
memory is unknown. So after bootup, when the address has been
determined, I patch all the virt<->phys constants used throughout the
kernel.

The memory on an APUS system is contiguous though, so the fix used on
APUS may not be enough for you.


My code is not in the vger tree yet. If you want to have a look at it,
get a diff from ftp://sunsite.auc.dk/local/os/linux/apus/kernels (or
thereabouts).

Jesper

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
