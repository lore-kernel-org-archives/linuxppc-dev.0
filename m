Message-ID: <3873B3E1.B7823BEA@talknet.de>
Date: Wed, 05 Jan 2000 22:13:05 +0100
From: Alois Fertl <alois_fertl@talknet.de>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: LinuxppcDev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Changes for IDE on PREP Hardware
References: <38710186.B7930E52@talknet.de> <20000104222421.A31468@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Cort Dougan wrote:
> 
> } Attached is a patch which allows to work Motorola PREP hardware (like
> } Blackhawk) to use IDE devices (disk and cdrom). The patch tries to
> } selectively introduce the changes for the Motorola hardware only.
> } IBM's can stay with their irq 13 for IDE and with their preferred
> } method of non swapped data stream. I have no chance to test on IBM.
> 
> How would this work if both irqs arrive at the same time?
> 
> Johnnie, Matt - can you test this out on your systems?

Which two irqs do you mean?


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
