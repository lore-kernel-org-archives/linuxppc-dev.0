Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A8594DDF59
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 18:39:24 +1000 (EST)
Subject: Re: [RFC 1/3] cryptoapi: AES with AltiVec support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Sebastian Siewior <bigeasy@linux.vnet.ibm.com>
In-Reply-To: <461DE3B6.8010503@linux.vnet.ibm.com>
References: <20070411164910.657151000@linux.vnet.ibm.com> >
	<20070411165702.256910000@linux.vnet.ibm.com> >
	<1176330126.8061.110.camel@localhost.localdomain>
	<461DE3B6.8010503@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Thu, 12 Apr 2007 18:39:14 +1000
Message-Id: <1176367154.5764.0.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



> Yes. aes-altivec.o contains the -maltivec flag and is the only module 
> using AltiVec. aes-alti.o uses enable_kernel_altivec & 
> disable_kernel_altivec and calls then the AltiVec module.
> The raid6 code compiles the raid[1,2,4,8].c files with -maltivec flag 
> and uses the noinline keyword in the function that uses AltiVec.
> Should I prefer the latter or were you confused with with the - _ in the 
> filename and you recommend renaming them?

Nah, your stuff looks fine, I got confused.

Ben.
