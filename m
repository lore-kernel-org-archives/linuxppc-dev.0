Return-Path: <jdl@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id E5BCD67BE0
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Jun 2006 23:43:31 +1000 (EST)
Subject: Re: [PATCH 6/10] Add 8641 Register space and IRQ definitions.
From: Jon Loeliger <jdl@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <EDB92A0C-28BA-4E18-98ED-F37C1EEDF8C2@kernel.crashing.org>
References: <1149720021.23938.198.camel@cashmere.sps.mot.com>
	<EDB92A0C-28BA-4E18-98ED-F37C1EEDF8C2@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1149773970.23938.230.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 08:39:30 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-06-07 at 23:57, Kumar Gala wrote:


> > +/* Offset from CCSRBAR */
> > +#define MPC86xx_DMA_OFFSET	(0x21000)
> > +#define MPC86xx_DMA_SIZE	(0x01000)
> > +#define MPC86xx_DMA0_OFFSET	(0x21100)
> > +#define MPC86xx_DMA0_SIZE	(0x00080)
> > +#define MPC86xx_DMA1_OFFSET	(0x21180)
> > +#define MPC86xx_DMA1_SIZE	(0x00080)
> > +#define MPC86xx_DMA2_OFFSET	(0x21200)
> > +#define MPC86xx_DMA2_SIZE	(0x00080)
> > +#define MPC86xx_DMA3_OFFSET	(0x21280)
> > +#define MPC86xx_DMA3_SIZE	(0x00080)
> > +
> > +#define MPC86xx_GUTS_OFFSET	(0xe0000)
> > +#define MPC86xx_GUTS_SIZE	(0x01000)
> > +
> > +#define MPC86xx_OPENPIC_OFFSET	(0x40000)
> > +#define MPC86xx_OPENPIC_SIZE	(0x40000)
> > +#define MPC86xx_PEX1_OFFSET	(0x08000)
> > +#define MPC86xx_PEX1_SIZE	(0x01000)
> > +#define MPC86xx_PEX2_OFFSET	(0x09000)
> > +#define MPC86xx_PEX2_SIZE	(0x01000)
> > +#define MPC86xx_PERFMON_OFFSET	(0xe1000)
> > +#define MPC86xx_PERFMON_SIZE	(0x01000)
> > +#define MPC86xx_UART0_OFFSET	(0x04500)
> > +#define MPC86xx_UART0_SIZE	(0x00100)
> > +#define MPC86xx_UART1_OFFSET	(0x04600)
> > +#define MPC86xx_UART1_SIZE	(0x00100)
> > +#define MPC86xx_MCM_OFFSET      (0x00000)
> > +#define MPC86xx_MCM_SIZE        (0x02000)
> > +
> > +#define MPC86xx_CCSRBAR_SIZE	(1024*1024)
> 
> Let's kill any OFFSET & SIZEs that aren't actually needed in code.  I  
> would hope most of these are going from the flat dev tree.

OK.  I'll trim this set down.


> > +enum ppc_sys_devices {
> > +	MPC86xx_TSEC1,
> > +	MPC86xx_TSEC2,
> > +	MPC86xx_TSEC3,
> > +	MPC86xx_TSEC4,
> > +	MPC86xx_DUART,
> > +	MPC86xx_MDIO,
> > +	MPC86xx_IIC1,
> > +	MPC86xx_IIC2,
> > +	NUM_PPC_SYS_DEVS,
> > +};
> 
> please kill, I can't imagine any code actually using this.

Yep.  Again, leftover tidbits.  I'll fix it.


> > +#define PVR_8641	0x80040000
> 
> Does anything code use this define, if not let's kill it.  I think we  
> are trying to reduce such things.

I'll check and remove as possible!

Thanks,
jdl
