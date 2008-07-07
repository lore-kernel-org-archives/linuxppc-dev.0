Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CF591DE9E5
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jul 2008 08:06:19 +1000 (EST)
Subject: Re: [PATCH] [V2] powerpc: legacy_serial: reg-offset & shift aren't
	used
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080707070124.73ba794f@zod.rchland.ibm.com>
References: <20080701175250.E0BA41CE804D@mail117-va3.bigfish.com>
	<1215413228.8970.106.camel@pasglop>
	<20080707070124.73ba794f@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 08 Jul 2008 08:00:04 +1000
Message-Id: <1215468004.8970.118.camel@pasglop>
Mime-Version: 1.0
Cc: dwg@au1.ibm.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	John Linn <john.linn@xilinx.com>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> >  - First if the properties are present but their value match the
> > register layout of a standard UART, we will bail out... not nice.
> 
> Why would they be present in that case?

Why not ?

> >  - Why don't we just implement support for the reg-shift and
> > offset instead ?
> 
> Probably because the last time someone suggested that it spawned a
> lengthy debate about what reg-offset/shift were supposed to do.

That's lame, their definition is already quite there.

Ben.
