Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-04.arcor-online.net (mail-in-04.arcor-online.net
	[151.189.21.44])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 4EA56DDE0A
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Jun 2007 21:35:54 +1000 (EST)
In-Reply-To: <18030.32600.921348.218117@cargo.ozlabs.ibm.com>
References: <20070611232824.489103547@arndb.de>
	<20070611233353.734704855@arndb.de>
	<18030.15937.699275.958545@cargo.ozlabs.ibm.com>
	<200706121008.01661.arnd@arndb.de>
	<18030.32600.921348.218117@cargo.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <d8ba058b9bc8f9738d2c3d764c568c1e@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 02/10] powerpc: Move CONFIG_PPC64 into CPU selection
Date: Tue, 12 Jun 2007 13:35:29 +0200
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@ozlabs.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> * The only major difference between ppc64 and the others is the
>>   object format of the kernel binary.
>
> I disagree with that.  There are major differences at the
> implementation level for a lot of things.

It would be good to converge the 32- and 64-bit implementations,
and/or allow a single kernel image to work on both 32-bit and
64-bit systems,  The current situation is far removed from that,
so this patch is a bit premature in that aspect.


Segher
