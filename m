Content-Type: text/plain;
  charset="iso-8859-1"
From: Trevor Woerner <ppc339@vtnet.ca>
Reply-To: ppc339@vtnet.ca
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: ide interrupts
Date: Sun, 25 May 2003 19:12:24 -0400
References: <200305231136.51119.ppc339@vtnet.ca> <1053706196.580.1.camel@gaston>
In-Reply-To: <1053706196.580.1.camel@gaston>
MIME-Version: 1.0
Message-Id: <200305251912.24266.ppc339@vtnet.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On May 23, 2003 12:09 pm, Benjamin Herrenschmidt wrote:
> On Fri, 2003-05-23 at 17:36, Trevor Woerner wrote:
> > There seems to be a lot of code in the IDE subsystem relating to
> > interrupts. Is there a way to set a device in polled (i.e.
> > non-interrupt) mode? Maybe some way to run the tasklet/bh
> > periodically?
> >
> > Does the IDE system want to monitor my ATA device's Ready_NotBusy
> > interrupt?
>
> No, linux IDE layer can't do that in a sane way, you are asking for
> a _lot_ of trouble... (especially if doing DMA)

"No" there isn't a way to set the device into polled mode, or "No" it
doesn't monitor the Ready_NotBusy interrupt?

	Trevor

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
