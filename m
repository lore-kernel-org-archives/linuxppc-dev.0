Return-Path: <Emilian.Medve@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: [PATCH] [POWERPC] Fix return value check logic
Date: Fri, 23 May 2008 07:39:58 -0700
Message-ID: <598D5675D34BE349929AF5EDE9B03E2701F48298@az33exm24.fsl.freescale.net>
In-Reply-To: <598D5675D34BE349929AF5EDE9B03E2701F4828E@az33exm24.fsl.freescale.net>
References: <1211485762-29637-1-git-send-email-Emilian.Medve@Freescale.com><1211505190.7671.6.camel@localhost>
	<598D5675D34BE349929AF5EDE9B03E2701F4828E@az33exm24.fsl.freescale.net>
From: "Medve Emilian" <Emilian.Medve@freescale.com>
To: <michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello Michael,


> > That won't work if CONFIG_DEBUG_FS is not defined, because in=20
> > that case
> > debugfs_create_file() returns -ENODEV.
>=20
> Will respin.

At a second glance in arch/powerpc/Kconfig.debug, VIRQ_DEBUG depends on
DEBUG_FS so I think that the patch should work as is.


Cheers,
Emil.
