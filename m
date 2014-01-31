Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0209.outbound.protection.outlook.com [207.46.163.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 924042C009F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Jan 2014 14:47:29 +1100 (EST)
Message-ID: <1391140038.6733.41.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2][v7] driver/memory:Move Freescale IFC driver to a
 common driver
From: Scott Wood <scottwood@freescale.com>
To: Kushwaha Prabhakar-B32579 <prabhakar@freescale.com>
Date: Thu, 30 Jan 2014 21:47:18 -0600
In-Reply-To: <cc597cc6590e4eb7b7d6fbc004fbf749@DM2PR03MB464.namprd03.prod.outlook.com>
References: <1390886979-9341-1-git-send-email-prabhakar@freescale.com>
 <1391117477.6733.39.camel@snotra.buserror.net>
 <cc597cc6590e4eb7b7d6fbc004fbf749@DM2PR03MB464.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-01-30 at 21:23 -0600, Kushwaha Prabhakar-B32579 wrote:
> 
> > -----Original Message-----
> > From: Wood Scott-B07421
> > Sent: Friday, January 31, 2014 3:01 AM
> > To: Kushwaha Prabhakar-B32579
> > Cc: linuxppc-dev@lists.ozlabs.org
> > Subject: Re: [PATCH 1/2][v7] driver/memory:Move Freescale IFC driver to a common
> > driver
> > 
> > On Tue, 2014-01-28 at 10:59 +0530, Prabhakar Kushwaha wrote:
> > >  Freescale IFC controller has been used for mpc8xxx. It will be used
> > > for ARM-based SoC as well. This patch moves the driver to
> > > driver/memory  and fix the header file includes.
> > >
> > >  Also remove module_platform_driver() and  instead call
> > >  platform_driver_register() from subsys_initcall() to make sure this
> > > module  has been loaded before MTD partition parsing starts.
> > >
> > > Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
> > > Acked-by: Arnd Bergmann <arnd@arndb.de>
> > 
> > When did Arnd ack this?  Especially in v7 form... and I don't see him on CC.
> > 
> > > +config FSL_IFC
> > > +	bool "Freescale Integrated Flash Controller"
> > > +	depends on FSL_SOC
> > > +	help
> > > +	  This driver is for the Integrated Flash Controller Controller(IFC)
> > 
> > Controller Controller?
> 
> I will fix it
> 
> > 
> > > +	  module available in Freescale SoCs. This controller allows to handle
> > flash
> > > +	  devices such as NOR, NAND, FPGA and ASIC etc
> > 
> > FPGA and ASIC are not (necessarily) flash devices.
> > 
> 
> Yes it true. 
> I am not sure this folder is only for flash controller.
> I can see references of FPGA, SRAM in same Kconfigs. 

Right, just fix the help text.
s/handle flash devices/handle devices/

-Scott
