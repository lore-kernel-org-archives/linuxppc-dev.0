Message-Id: <199901091003.LAA00374@piglet.cpu.lu>
Date: Sat, 9 Jan 1999 11:03:17 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: PCI Detection/ programming / GPIB
To: kozioziemski1@llnl.gov
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <m3k8yz3s7b.fsf@unites9500.llnl.gov>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On   7 Jan, this message from Bernard Kozioziemski echoed through cyberspace:
> I have a National Instruments PCI GPIB (IEE-488) card installed in my
> PowerMac 9500. There is some work on the x86 front to support GPIB, so I
> thought I'd start there. Unfortunately, the card is not found by linux when
> booting. /proc/pci lists 3 devices: Apple Bandit, VGA compat controller
> (grpahics card) and Apple Grand Central. I'm not sure where to start in
> detecting this board, and I was wondering if someone on this list could
> give me a few pointers to (beginner :) info, or example code. Thanks,

Problem is that you probably have your card in the slots controlled by
the second bandit host bridge; which is not automatically scanned.

Try moving your card into a different slot (close to the graphics
card). Of the six slots, three each are controlled by a separate bandit
host bridge.

I'm working on a patch that scans the second PCI bus as well. I'll let
you know when I have something available.

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
9, Montee St. Crepin           |    Ask Questions.  Make Mistakes.
L-1365 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


[[ This message was sent via the linuxppc-dev mailing list. Replies are ]]
[[ not forced back to the list, so be sure to  Cc linuxppc-dev  if your ]]
[[ reply is of general interest. To unsubscribe from linuxppc-dev, send ]]
[[ the message 'unsubscribe' to linuxppc-dev-request@lists.linuxppc.org ]]
