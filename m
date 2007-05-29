Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CA42DE038
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 07:38:54 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Steve Munroe <sjmunroe@us.ibm.com>
In-Reply-To: <1180474661.19517.197.camel@localhost.localdomain>
References: <OF23D1348F.B2E0AE28-ON862572EA.004C17B2-862572EA.004CF843@us.ibm.com>
	<1180474661.19517.197.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 30 May 2007 07:38:42 +1000
Message-Id: <1180474722.19517.200.camel@localhost.localdomain>
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


> BUT WE ARE NOT CHANGING THE BLOODY ABI IN ANY INCOMPATIBLE WAY SHAPE OR
> FORM AND THERE IS NO NEED TO CHANGE GLIBC ! Have I been clear enough ?
> If not, I'll let Uli explain why again for the 4th time at least.

Sorry for the shouting... shouldn't reply to email before I had
breakfast :-)

Cheers,
Ben.
