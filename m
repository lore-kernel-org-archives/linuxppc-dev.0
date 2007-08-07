Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E000DDE16
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Aug 2007 23:11:22 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l77C4pkc004262
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 08:04:51 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.4) with ESMTP id
	l77DBGrH207258
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 07:11:16 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l77DBFfS012118
	for <linuxppc-dev@ozlabs.org>; Tue, 7 Aug 2007 07:11:16 -0600
Date: Tue, 7 Aug 2007 08:11:14 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [patch 08/10] Bamboo DTS
Message-ID: <20070807081114.7ca87fd2@weaponx.rchland.ibm.com>
In-Reply-To: <20070806045332.GA11051@localhost.localdomain>
References: <20070803160900.069522000@linux.vnet.ibm.com>
	<20070803161711.202342000@linux.vnet.ibm.com>
	<20070806045332.GA11051@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Aug 2007 14:53:32 +1000
David Gibson <dwg@au1.ibm.com> wrote:

> On Fri, Aug 03, 2007 at 11:09:08AM -0500, Josh Boyer wrote:
> > AMCC Bamboo board DTS
> 
> All the compatible properties should have "XXXX-440ep" as the most
> precise version, in addition to the more general strings.

Done.

> > --- /dev/null
> > +++ linux-2.6/arch/powerpc/boot/dts/bamboo.dts
> > @@ -0,0 +1,248 @@
> > +/*
> > + * Device Tree Source for AMCC Bamboo
> > + *
> > + * Copyright (c) 2006, 2007 IBM Corp.
> > + * Josh Boyer <jwboyer@linux.vnet.ibm.com>
> > + *
> > + * FIXME: Draft only!
> > + *
> > + * This file is licensed under the terms of the GNU General Public
> > + * License version 2.  This program is licensed "as is" without
> > + * any warranty of any kind, whether express or implied.
> > + *
> > + * To build:
> > + *   dtc -I dts -O asm -o bamboo.S -b 0 bamboo.dts
> > + *   dtc -I dts -O dtb -o bamboo.dtb -b 0 bamboo.dts
> 
> Can we ditch this "to build" boilerplate.  It's just another thing
> people frequently forget to update as they copy it from dts to dts.

Removed.

josh
