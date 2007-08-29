Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8D0A9DDE24
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 22:26:37 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e36.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l7TCQEmH012195
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 08:26:14 -0400
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l7TCQDXv392350
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:26:13 -0600
Received: from d03av01.boulder.ibm.com (loopback [127.0.0.1])
	by d03av01.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l7TCQDUR029311
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Aug 2007 06:26:13 -0600
Date: Wed, 29 Aug 2007 07:26:12 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH 1/4] PowerPC 440EPx: Sequoia bootwrapper
Message-ID: <20070829072612.47ac9134@weaponx.rchland.ibm.com>
In-Reply-To: <200708291428.23522.sr@denx.de>
References: <20070828165321.GA1501@ru.mvista.com>
	<20070828130921.13809093@weaponx.rchland.ibm.com>
	<46D56226.8020500@ru.mvista.com> <200708291428.23522.sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 29 Aug 2007 14:28:23 +0200
Stefan Roese <sr@denx.de> wrote:

> On Wednesday 29 August 2007, Valentine Barshak wrote:
> > >> +#define DDR_GET_VAL(val, mask, shift)	(((val) >> (shift)) & (mask))
> > >
> > > Hm.  Having these as just DDR_... seems like it would lead to confusion
> > > if there are other DDR controllers that get added later.  But I'm not
> > > too picky either way.
> >
> > What names would you suggest? DDR_DENALI_... looks too long :)
> > The names have been taken from the docs, I've just prefixed them with DDR_.
> 
> It's such a generic macro and not Denali or even SDRAM specific. So it really 
> should be no problem to keep it as is.

I wasn't talking about DDR_GET_VAL.  I meant having the DDR registers
defines just as "DDR_START", "DDR_START_SHIFT", etc could be confusing
later.

But I don't really see a need to change it at the moment.  We can
prefix the with something else if a conflicting DDR controller ever
shows up.

josh
