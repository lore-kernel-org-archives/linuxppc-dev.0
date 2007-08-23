Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
Date: Wed, 22 Aug 2007 22:33:55 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 10:19 AM, Kumar Gala wrote:

> Guys,
>
> I was wondering if I could get your help with looking at the
> following lists and determining if we have an issue or not related
> the following files:
>
> Getting some classification on these would be good.  Possibly
> classifications, doesn't build in ARCH=powerpc, remove include, real
> issue, etc.
>
> - k

My analysis of <asm/bootinfo.h> usage:

./drivers/macintosh/adb-iop.c:#include <asm/bootinfo.h>		remove
./drivers/char/vme_scc.c:#include <asm/bootinfo.h>		68k only
./drivers/char/serial167.c:#include <asm/bootinfo.h>		68k only
./drivers/serial/dz.c:#include <asm/bootinfo.h>			decstation
./drivers/mtd/devices/ms02-nv.c:#include <asm/bootinfo.h>	decstation
./drivers/net/macsonic.c:#include <asm/bootinfo.h>		68k
./drivers/net/jazzsonic.c:#include <asm/bootinfo.h>		mips
./drivers/video/pmag-aa-fb.c:#include <asm/bootinfo.h>		mips
./drivers/video/maxinefb.c:#include <asm/bootinfo.h>		mips
./drivers/video/logo/logo.c:#include <asm/bootinfo.h>		mips
./drivers/video/macfb.c:#include <asm/bootinfo.h>		68k
./drivers/video/valkyriefb.c:#include <asm/bootinfo.h>		68k

- k
