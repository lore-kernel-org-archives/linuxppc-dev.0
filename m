Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9049DDDF9E
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Apr 2009 20:44:19 +1000 (EST)
Subject: Re: issues w/init
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <18920.21593.737132.732053@cargo.ozlabs.ibm.com>
References: <680ABFDC-A67F-48BB-B46C-564CB5373FEB@kernel.crashing.org>
	<88F07543-B7F6-4F27-B5FB-4780AD069D7E@kernel.crashing.org>
	<49E78620.7070303@freescale.com>
	<C17084D8-19F7-48D2-8E7E-2DE561108A90@kernel.crashing.org>
	<1239953907.7443.45.camel@pasglop>
	<18920.21593.737132.732053@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Fri, 17 Apr 2009 12:33:45 +0200
Message-Id: <1239964425.7443.61.camel@pasglop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-04-17 at 20:05 +1000, Paul Mackerras wrote:
> Benjamin Herrenschmidt writes:
> 
> > I'm pretty sure they are broken already when running off a 64-bit
> > kernel,
> 
> Maybe not... for 64-bit kernels we have our definition of
> elf_read_implies_exec in arch/powerpc/include/asm/elf.h, which IIRC
> sets the read-implies-exec personality thing on old 32-bit binaries.

All or old ? ie. can we differenciate the broken from the "good" ones ? 
In which case we can just fix that up here too.

Cheers,
Ben.
