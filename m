Subject: Re: ide interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: ppc339@vtnet.ca
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <200305231136.51119.ppc339@vtnet.ca>
References: <200305231136.51119.ppc339@vtnet.ca>
Content-Type: text/plain
Message-Id: <1053706196.580.1.camel@gaston>
Mime-Version: 1.0
Date: 23 May 2003 18:09:57 +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-05-23 at 17:36, Trevor Woerner wrote:
> There seems to be a lot of code in the IDE subsystem relating to
> interrupts. Is there a way to set a device in polled (i.e.
> non-interrupt) mode? Maybe some way to run the tasklet/bh periodically?
>
> Does the IDE system want to monitor my ATA device's Ready_NotBusy
> interrupt?

No, linux IDE layer can't do that in a sane way, you are asking for
a _lot_ of trouble... (especially if doing DMA)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
