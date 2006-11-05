Return-Path: <nd@bplan-gmbh.de>
Date: Sun, 5 Nov 2006 12:30:59 +0100 (MET)
From: Nicolas DET <nd@bplan-gmbh.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH/RFC] powerpc: Add MPC5200 Interrupt Controller support.
Message-Id: <20061105123101.3cc1696f.nd@bplan-gmbh.de>
In-Reply-To: <1162723031.28571.228.camel@localhost.localdomain>
References: <454902F9.20206@bplan-gmbh.de>	<1162419138.25682.453.camel@localhost.localdomain>	<454A1C37.5050208@bplan-gmbh.de>	<454A5952.6090801@bplan-gmbh.de>	<1162683341.28571.82.camel@localhost.localdomain>	<20061105111753.3e41f6b7.nd@bplan-gmbh.de>	<1162723031.28571.228.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>, sl@bplan-gmbh.de,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 05 Nov 2006 21:37:11 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> 
> > > You have changed the mapping of L1/L2 but not the device-tree
> > > representation to match them. Which means that you need the ugly hack
> > > above. That is not goot. Fix your device-tree instead and do the same
> > > split in the tree for L1/L2 than you do in the code.
> > 
> > There is no option here.
> 
> I don't agree. Your firmware can always be upgraded. There is no way you
> will impose a broken format on everybody else. Unfortunately, being the
> first implementation, that's just what you are doing...
> 

As said, no option here. I think there is different way to see how works the PIC. However, from a register point of view. There is just critical, main, peripherals, SDMA.

Loot at "ICTL Perstat, MainStat, MainStat, CritStat Encoded Register--MBAR + 0x0524"

Page 160 of the MPC5200BUM.pdf.

> At worst, you'll have to do a fixup pass in prom_init.c
> 

If you really want to change the pic driver, tell me the way to adapt prom_init.c
However, I do think we do it the right way.

Regards,
