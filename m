Return-Path: <monstr@seznam.cz>
Received: from smtp.seznam.cz (smtp.seznam.cz [77.75.72.43])
	by ozlabs.org (Postfix) with ESMTP id C554BDE1D8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Aug 2008 22:26:09 +1000 (EST)
Message-ID: <48AC0A5B.3060909@seznam.cz>
Date: Wed, 20 Aug 2008 14:13:15 +0200
From: Michal Simek <monstr@seznam.cz>
MIME-Version: 1.0
To: Philipp Hachtmann <hachti@hachti.de>
Subject: Re: U-boot and Xilinx emaclite, TX_PING_PONG -> stops working
References: <931ae8260808160434g1ff6d856n46e5e420e487db57@mail.gmail.com>
	<48A7302F.8030707@hachti.de>
In-Reply-To: <48A7302F.8030707@hachti.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-embedded@ozlabs.org
Reply-To: monstr@seznam.cz
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Philipp,

I did U-BOOT driver for emaclite. You can set both ping pong mode - all
combination are supported. I tested this driver with Microblaze and works well.
I use this driver almost every day and I have no problem with it. If you have
problem with this driver please send your email to u-boot mailing list.

Regards,
Michal


> Hi all,
> 
> I use a Xilinx Virtex-4FX (with powerpc) Board (Ml403) with U-boot and
> Linux.
> 
> I am currently wondering if someone has experience with the emaclite
> driver. When I unset the "ping pong" (double buffering) parameters of
> the core, I can use it unter Linux and U-boot. But the performance is
> near to non-functional (wget tells me about 10kByte/sec).
> Then I switched to double buffering. Now it runs very well - but only
> under Linux.
> 
> I found a driver (xilinx_emaclite.c) in the U-boot git. That completely
> refuses to work correctly (of course with parameters corrected). The
> other driver I once found "somewhere" (in the Petalinux distribution).
> It at least worked without the double buffering. Both drivers talk about
> the ping pong options in their source, so I think they *should* know
> about it.
> 
> 
> Does anyone know that problem? Is there an improved driver around?
> 
> Best wishes,
> 
> Philipp
> 
> 
> 
> 
> 
