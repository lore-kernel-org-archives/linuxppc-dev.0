Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A1771DDF25
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:37:53 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
In-Reply-To: <OF23D1348F.B2E0AE28-ON862572EA.004C17B2-862572EA.004CF843@us.ibm.com>
References: <OF23D1348F.B2E0AE28-ON862572EA.004C17B2-862572EA.004CF843@us.ibm.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 07:37:41 +1000
Message-Id: <1180474661.19517.197.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-05-29 at 09:00 -0500, Steve Munroe wrote:
> 
> >
> Yes exactly why make an incompatible ABI change to the powerp32 ABI,
> when you can just use the existing 64-bit ABI.

Why do you keep saying we are making an incompatible ABI change while we
are not ?

> Especially as you can only run what is proposed on 64-bit hardware!

Because people want to do it ... I suspect this has a lot to do with not
having 64 bits pointers or providing specific optimisations in low level
routines within overall 32 bits apps but I don't know the details.

> We don't need another ABI change to powerpc32 (still recovering from
> the
> -msecure-plt ABI change) and WE DONT NEED a 3rd ABI.
>
> ABI changes ripple everywhere (not just GCC/GLIBC) including all
> debuggers
> and performance tools. Believe me you really don't want this.

BUT WE ARE NOT CHANGING THE BLOODY ABI IN ANY INCOMPATIBLE WAY SHAPE OR
FORM AND THERE IS NO NEED TO CHANGE GLIBC ! Have I been clear enough ?
If not, I'll let Uli explain why again for the 4th time at least.

Ben.
