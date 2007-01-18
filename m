Return-Path: <BSowislo@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 56CC4DDE07
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Jan 2007 05:18:41 +1100 (EST)
From: "Bernd Sowislo" <BSowislo@gmx.de>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: AW: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
Date: Thu, 18 Jan 2007 19:18:24 +0100
Message-ID: <EJEFJPEGEFDHNKNCEDPOAEJPCEAA.BSowislo@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
In-Reply-To: <EJEFJPEGEFDHNKNCEDPOEEJOCEAA.BSowislo@gmx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>
> -----Ursprüngliche Nachricht-----
> Von: Bernd Sowislo [mailto:BSowislo@gmx.de]
> Gesendet: Donnerstag, 18. Januar 2007 17:21
> An: Grant Likely
> Betreff: AW: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
>
> Hi glikely,

> > -----Ursprüngliche Nachricht-----
> > Von: glikely@gmail.com [mailto:glikely@gmail.com]Im Auftrag von Grant
> > Likely
> > Gesendet: Donnerstag, 18. Januar 2007 07:28
> > An: Bernd Sowislo; linuxppc-embedded list
> > Betreff: Re: Fw: [Bugme-new] [Bug 7808] New: Xilinx ML403 does not boot
>
>
> > > On 1/17/07, Bernd Sowislo <BSowislo@gmx.de> wrote:
> > > Hi,
> > > I have seen your name in the header of
> > > the files for the temac implementation
> > > of the ml403 board.
> > > Meanwhile I know what is the reason
> > > for the hangup of my kernel at boot time
> > > when I insert the patches for the temac
> > > into the xilinx_ml403.c code (two places)
> > >
> > >  1.) increment ther number of devices scanned at early boot
> > >  2.) insert the temac routines in ml403_setup_arch()
> > >
> > > the systems stops execution.
> >
> > Do you get any log output at all?  Post it here if you do.
> >
> loaded at:     00400000 0063913C
> board data at: 00637120 00637138
> relocated to:  00404060 00404078
> zimage at:     00404E31 004D2397
> initrd at:     004D3000 00636284
> avail ram:     0063A000 04000000
>
> Linux/PPC load: console=ttyS0,9600 ramdisk_size=8192 root=/dev/ram
> Uncompressing Linux...done.
> Now booting the kernel
>
> that's all
>
> > >
> > > First I thought it was my fault because I use temac 2.0
> > > with DMA 3.0 and your driver obviously uses DMA 2.0 and temac 1.0
> >
> > It's not my driver; I've haven't got the temac driver working on my
> > board yet.  But there are folks on this list who can help you out.
> >
> >
> > > then I changed the code (adapter.c) for use of DMA 3.0 and temac 2.0
> > > as described in the xilinx example for DMA test but
> > > even if I use fifo 2.0 mode I have this hangup.
> > >
> > > Do you have a driver patch for temac 2.0 with DMA 3.0
> > > or are you interested in my try to change the code?
> >
> > The Xilinx drivers are a bit of a disaster at the moment in that it
> > takes a lot of work to get them right.  Go ahead and change the code.
> > Fill it with debug output; whatever you need to figure out what's
> > going on.
> > >
> > >
> > > how can I debug the booting kernel.
> > >
> > Best way is with some kind of JTAG debugger.  I personally use a
> > BDI-2000 from Abatron.  I think others have had good luck with the
> > Xilinx JTAG pod.
> >
> >
> > >  my experience in linux is 8 weeks, OVMS 15 years
> >
> > OVMS?
> >
> developed from digital for VAX (32bit, later 64bit for Alpha)
> >
> > --
> > Grant Likely, B.Sc. P.Eng.
> > Secret Lab Technologies Ltd.
> > grant.likely@secretlab.ca
> > (403) 399-0195
