Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 8DF03DDF25
	for <linuxppc-dev@ozlabs.org>; Thu,  1 May 2008 10:01:55 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] convert transfer_to_handler into a macro
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20080430184502.4f0c66e2@zod.rchland.ibm.com>
References: <Pine.LNX.4.64.0804290856210.9230@blarg.am.freescale.net>
	<18455.37613.709102.30668@cargo.ozlabs.ibm.com>
	<73CD5806-5CE4-40A7-957B-8F164E26FAFB@kernel.crashing.org>
	<1209537128.18023.225.camel@pasglop>
	<EDF2E889-4B04-42A8-8D93-E04B35162661@kernel.crashing.org>
	<1209592794.18023.248.camel@pasglop>
	<2A2997EA-F3AF-4C90-8952-42CA48AA07BC@kernel.crashing.org>
	<20080430184502.4f0c66e2@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 01 May 2008 09:53:22 +1000
Message-Id: <1209599602.18023.273.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-04-30 at 18:45 -0500, Josh Boyer wrote:
> > thanks.  Will take a look.  I just plan on overloading MMUCR with
> MAS0.
> 
> Erg.  Why?  Please don't do that.  This is common code and MAS0
> doesn't
> make much sense on 4xx.  It'll be confusing to anyone that isn't aware
> of this change.

Nah, he meant using the slot for MAS0 in the exception frame structure
as to not have to define two different structures I suppose...

> Can we come up with a generic #define that gets used instead?
> 
> josh

Ben.
