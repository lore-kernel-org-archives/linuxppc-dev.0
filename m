Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <4059C35A.1000203@fh-landshut.de>
Date: Thu, 18 Mar 2004 16:42:18 +0100
From: Oliver Korpilla <okorpil@fh-landshut.de>
Reply-To: okorpil@fh-landshut.de
MIME-Version: 1.0
To: Marius Groeger <mgroeger@sysgo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux and RTAI on the Motorola VME Boards
References: <40597103.3090704@fh-landshut.de> <Pine.LNX.4.56.0403181202500.4114@mag.sysgo.com>
In-Reply-To: <Pine.LNX.4.56.0403181202500.4114@mag.sysgo.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>However, RTAI does share the kernel memory map, so any memory region mapped
>by the Linux kernel (or a driver) is also visible to RTAI.
>
>
Actually, from reading the RTAI mailing list, it may just be possible to
let a Linux driver establish the necessary mappings, and use those in a
RTAI task. If I catch the interrupts related to that device (that info
should be obtainable , too, on task initialization, where real-time
isn't needed) and process them only in the RTAI space, using the
established mappings, this could actually be sufficient for my purposes.
I first have to evaluate that.

>I don't know the VME driver you're about to use, but you should be
>able to safely use the VME memory regions it maps.
>
>BTW, you may want to join the RTAI list,
>
I did. :)

Since enough of the entries on this list seem to refer to VME stuff on
MVME boards, and solutions with RTAI and Linux were proposed or offered
here as well (for example by Xavier Grave), I thought it to be wise to
drop a mail here still.

Of course I would be grateful on any help about drivers, stuff, and
(open?) BSPs about those boards (MVME 2100, MVME 5500) in general, too! :)

Thanks,
Oliver Korpilla
CS Student at the University of Applied Sciences at Landshut, Germany

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
