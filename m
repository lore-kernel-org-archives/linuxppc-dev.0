Return-Path: <jdl@freescale.com>
Subject: Re: [PATCH 9/10] Add device tree for Ebony
From: Jon Loeliger <jdl@freescale.com>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20070418063626.D5DCCDDEBA@ozlabs.org>
References: <20070418063626.D5DCCDDEBA@ozlabs.org>
Content-Type: text/plain
Message-Id: <1177006172.14328.13.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 19 Apr 2007 13:09:32 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-04-18 at 01:36, David Gibson wrote:
> Add a device tree for the Ebony evaluation board (440GP based).  This
> tree is not complete or finalized.  This tree needs a very recent
> version of dtc to process.

"recent" will get stale without absolute reference here.
In fact,  -V 16 is "old" now even. :-)


> --- /dev/null	1970-01-01 00:00:00.000000000 +0000
> +++ working-2.6/arch/powerpc/boot/dts/ebony.dts	2007-03-21 13:23:48.000000000 +1100
> @@ -0,0 +1,295 @@
> +/*
> + * Device Tree Source for IBM Ebony
> + *
> + * Copyright (c) 2006, 2007 IBM Corp.
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>, David Gibson <dwg@au1.ibm.com>
> + *
> + * FIXME: Draft only!

Hrm.

> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + *
> + * To build:
> + *   dtc -I dts -O asm -o ebony.S -b 0 -V 16 ebony.dts
> + *   dtc -I dts -O dtb -o ebony.dtb -b 0 -V 16 ebony.dts

Really Version 16?  Can we just default to latest version
by not specifying the -V arg at all?

Thanks,
jdl
