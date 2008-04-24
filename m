Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 12794DDEF7
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Apr 2008 10:45:32 +1000 (EST)
Subject: Re: Patches added to powerpc.git master and powerpc-next branches
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <CA750B46-2360-4C75-8F8E-5DFD0FB9807C@kernel.crashing.org>
References: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
	<9CE9EFA8-A303-49C9-B9A2-F62D42F927B7@kernel.crashing.org>
	<18441.58154.608911.337978@cargo.ozlabs.ibm.com>
	<C69E510D-5838-4BE6-AB57-56FCB0592414@kernel.crashing.org>
	<18445.11801.422321.151268@cargo.ozlabs.ibm.com>
	<CA750B46-2360-4C75-8F8E-5DFD0FB9807C@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 24 Apr 2008 10:45:24 +1000
Message-Id: <1208997924.9060.81.camel@pasglop>
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


On Wed, 2008-04-23 at 07:49 -0500, Kumar Gala wrote:
> its left over from the x86 port.  I'll get rid of
> __FIXADDR_BOOT_SIZE,  
> FIXADDR_BOOT_START, and __FIXADDR_TOP.
> 
> If we want the early ioremap support in the future we can add back  
> __FIXADDR_BOOT_SIZE and FIXADDR_BOOT_START.

Our early ioremap works differently. Do you see any reason why we may
want to do it like x86 instead ? Is it any better ?

Ben.
