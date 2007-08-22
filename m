Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E5DFDDF0F
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Aug 2007 09:26:26 +1000 (EST)
In-Reply-To: <200708230039.07061.arnd@arndb.de>
References: <18124.1591.112487.322248@cargo.ozlabs.ibm.com>
	<653AD812-D186-4876-BF52-F3A5D887B82E@kernel.crashing.org>
	<694575D6-C4BC-4FFB-91C1-B692181CEF6F@kernel.crashing.org>
	<200708230039.07061.arnd@arndb.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <9CF80662-71B6-4EA4-AEC5-CDF0842D5F26@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to powerpc.git for-2.6.24 branch
Date: Wed, 22 Aug 2007 18:28:22 -0500
To: Arnd Bergmann <arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 22, 2007, at 5:39 PM, Arnd Bergmann wrote:

> On Wednesday 22 August 2007, Kumar Gala wrote:
>> I think we can all agree that the amiga*.h, zorro.h and traps.h can
>> be ignored since they have to do with amiga/apus support.
>
> arch/powerpc/kernel/setup_32.c unconditionally #includes <asm/ 
> amigappc.h>,
> the rest looks unused indeed.

Yeah, that's fixed up in my patches.

- k
