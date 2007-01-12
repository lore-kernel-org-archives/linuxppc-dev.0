Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DE6ADDDF9D
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jan 2007 08:27:49 +1100 (EST)
Subject: Re: [patch][5/5] powerpc: Add the general support for Embedded
	Floating-Point instructions
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <615F9884-6695-485A-A4B4-A53BD98F969E@kernel.crashing.org>
References: <32F3CC26D4DAC44E8ECD07155727A46E816A47@zch01exm20.fsl.freescale.net>
	<1168599942.5011.21.camel@localhost.localdomain>
	<BDC705EB-9078-44FD-800E-D9ADD18B9471@kernel.crashing.org>
	<1168635154.5011.31.camel@localhost.localdomain>
	<615F9884-6695-485A-A4B4-A53BD98F969E@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 12 Jan 2007 21:27:57 +0000
Message-Id: <1168637277.5011.36.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> I think its a fair assumption that nothing is going to interrupt the  
> handling of the exception, so its safe to assume the process causing  
> the interrupt will be the same one we return to.

What about the get_user to get to the faulting instruction ? I suppose
if those processors are UP only and we use an exception with EE
disabled, there should be no way the page has been evicted since the
access, so that should work, but will that ever be true ?

Ben.
