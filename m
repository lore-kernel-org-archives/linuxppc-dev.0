Return-Path: <dwg@au1.ibm.com>
Received: from ausmtp06.au.ibm.com (ausmtp06.au.ibm.com [202.81.18.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "ausmtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9F403DDE1C
	for <linuxppc-dev@ozlabs.org>; Mon,  6 Aug 2007 15:00:22 +1000 (EST)
Received: from sd0109e.au.ibm.com (d23rh905.au.ibm.com [202.81.18.225])
	by ausmtp06.au.ibm.com (8.13.8/8.13.8) with ESMTP id l7652ugQ3408022
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 15:02:56 +1000
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.250.242])
	by sd0109e.au.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l7653qOH141556
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 15:03:52 +1000
Received: from d23av01.au.ibm.com (loopback [127.0.0.1])
	by d23av01.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7650JsQ007336
	for <linuxppc-dev@ozlabs.org>; Mon, 6 Aug 2007 15:00:19 +1000
Date: Mon, 6 Aug 2007 14:53:32 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [patch 08/10] Bamboo DTS
Message-ID: <20070806045332.GA11051@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com>>
	<20070803161711.202342000@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070803161711.202342000@linux.vnet.ibm.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Aug 03, 2007 at 11:09:08AM -0500, Josh Boyer wrote:
> AMCC Bamboo board DTS

All the compatible properties should have "XXXX-440ep" as the most
precise version, in addition to the more general strings.

> --- /dev/null
> +++ linux-2.6/arch/powerpc/boot/dts/bamboo.dts
> @@ -0,0 +1,248 @@
> +/*
> + * Device Tree Source for AMCC Bamboo
> + *
> + * Copyright (c) 2006, 2007 IBM Corp.
> + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> + *
> + * FIXME: Draft only!
> + *
> + * This file is licensed under the terms of the GNU General Public
> + * License version 2.  This program is licensed "as is" without
> + * any warranty of any kind, whether express or implied.
> + *
> + * To build:
> + *   dtc -I dts -O asm -o bamboo.S -b 0 bamboo.dts
> + *   dtc -I dts -O dtb -o bamboo.dtb -b 0 bamboo.dts

Can we ditch this "to build" boilerplate.  It's just another thing
people frequently forget to update as they copy it from dts to dts.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
