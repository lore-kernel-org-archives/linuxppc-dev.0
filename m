Message-ID: <3839CADC.CCDB6C7E@jlc.net>
Date: Mon, 22 Nov 1999 17:59:40 -0500
From: Dan Malek <dmalek@jlc.net>
MIME-Version: 1.0
To: Francois Guimond <fguimond@pplmail.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux ppc newbie boot sequense
References: <383993F5.BCE4A507@pplmail.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Francois Guimond wrote:


> I am trying to install a linux kernel on MPC8240 cpu in a limited flash
> space.
> (Motorola sandpoint evaluation platform 512kb flash 32MB ram and dink32
> software)


OK, I guess it is time to post what I have.  This is kinda, sorta running.

> I have got a PPC zImage compiled.

Unless you make a few changes in arch/ppc/kernel, including creating
some 8240 specific start up functions, it won't matter where you
place the First Instruction :-).


> Because there is no CPM  in it, I wanted to postpone the networking
> features.
> It means no root over nfs...

No, this works fine with a PCI Ethernet card.

Since the 8240/Sandpoint has such a small flash rom, it is your
only choice.  There isn't room to store a Linux kernel or compressed
ram disk.  You have to download the kernel over the serial port and
use diskless NFS.  Even though it has a standard IDE and floppy
interface, there are no provisions in Dink to load an image from
these.......Guess it is time to write yet another Linux flash rom.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
