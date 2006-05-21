Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 5A685679E1
	for <linuxppc-dev@ozlabs.org>; Mon, 22 May 2006 07:31:05 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 21 May 2006 23:30:56 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix ide-pmac sysfs entry
Message-ID: <20060521213056.GA25721@iram.es>
References: <1147676318.21291.105.camel@localhost.localdomain>
	<20060515000810.487b834e.akpm@osdl.org>
	<1147677830.21291.114.camel@localhost.localdomain>
	<20060515083847.GA5229@iram.es>
	<1147683156.21291.118.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1147683156.21291.118.camel@localhost.localdomain>
Cc: Andrew Morton <akpm@osdl.org>, Pete Popov <ppopov@embeddedalley.com>,
	B.Zolnierkiewicz@elka.pw.edu.pl, linuxppc-dev@ozlabs.org,
	paulus@samba.org, Alan Cox <alan@lxorguk.ukuu.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 15, 2006 at 06:52:36PM +1000, Benjamin Herrenschmidt wrote:
> 
> > Actually I have one of these, and regularly use it and update 
> > the kernel to the latest git once or twice per month, but I 
> > typically have two batteries and have not swapped in the 
> > media bay under Linux for a long time.
> > 
> > If you are interested, I could test the patch when I find 
> > some time (not today: my 8 year old son went to the hospital
> > for an emergency last Thursday, he is cured now and should 
> > come out today).
> 
> Any test is welcome, glad to know your son is well !

The one liner works here, I can no more solidly hang
the machine. There is still a bunch of error messages
on drive removal though:

mediabay0: switching to 7
mediabay0: powering down
media bay 0 is empty
Unregistering mb 0 ide, index:2
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: DMA disabled
hde: ATAPI reset complete
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: ATAPI reset complete
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: ATAPI reset complete
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
hde: ATAPI reset complete
hde: status error: status=0x00 { }
ide: failed opcode was: unknown
mediabay0: end of power down

On insertion there are also a few messages
but they seem normal:

mediabay0: switching to 3
mediabay0: powering up
mediabay0: enabling (kind:3)
mediabay0: waiting reset (kind:3)
mediabay0: waiting IDE reset (kind:3)
mediabay0: waiting IDE ready (kind:3)
mediabay 0, registering IDE...
Probing IDE interface ide2...
hde: LG DVD-ROM DRN-8080B, ATAPI CD/DVD-ROM drive
hde: Enabling MultiWord DMA 2
ide2 at 0xf1022000-0xf1022007,0xf1022160 on irq 20
hde: ATAPI 24X DVD-ROM drive, 512kB Cache, DMA
media-bay 0 is ide2
mediabay 0 IDE ready

	Regards,
	Gabriel
