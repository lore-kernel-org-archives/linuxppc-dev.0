Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Date: Fri, 2 Apr 2004 10:27:16 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Jeff Tucker <jeff@jltnet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on IBM 405EP eval board
Message-ID: <20040402182716.GC8540@gate.ebshome.net>
References: <1866383.1080909296@[192.168.0.230]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1866383.1080909296@[192.168.0.230]>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Apr 02, 2004 at 12:34:56PM -0500, Jeff Tucker wrote:
>
> Hi, guys.
>
> I sent a message like this to the U-Boot mailing list last night. I've been
> told this is definitely not a U-Boot problem, so I'm hoping that the people
> on this list can help me.
>
> I'm having a hard time getting U-Boot to boot Linux on an IBM 405EP
> evaluation board. Here's what I've tried:
>
> First, I think my kernels are fine. I can compile 2.4.18 from an older
> version of the ELDK or I can compile 2.4.24 from the latest released ELDK.
> I'm using ELDK tools for all of my builds. Using the IBM bootloader that
> comes on the board and the "treeboot" image file format, I can get the IBM
> board to tftp my kernel over the lan and run it. So, I think the kernel is
> working fine.

Hmm...

Standard bootloader which comes with 405ep eval board works fine with the Linux
kernel, U-Boot - doesn't, and you are being told that it's not a U-Boot
problem ?

So why don't you just use IBM bootloader and not U-Boot if you cannot get help
from u-boot maillist?

Eugene.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
