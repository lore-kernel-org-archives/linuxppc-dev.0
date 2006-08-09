Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id AB8CB67BA6
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 01:37:47 +1000 (EST)
Subject: Re: boot problems on pseries
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mark Fasheh <mark.fasheh@oracle.com>
In-Reply-To: <20060809013609.GA10876@ca-server1.us.oracle.com>
References: <20060809013609.GA10876@ca-server1.us.oracle.com>
Content-Type: text/plain
Date: Wed, 09 Aug 2006 17:37:30 +0200
Message-Id: <1155137850.17187.48.camel@localhost.localdomain>
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

On Tue, 2006-08-08 at 18:36 -0700, Mark Fasheh wrote:
> Hello,
> 	So I do most of my work on some IBM JS20 powerpc blades. They
> usually run a git kernel on a stock RHEL4 distribution. The contents of
> /proc/cpuinfo is:
> 
> processor       : 0
> cpu             : PPC970, altivec supported
> clock           : 1600.000000MHz
> revision        : 2.2 (pvr 0039 0202)
> 
> processor       : 1
> cpu             : PPC970, altivec supported
> clock           : 1600.000000MHz
> revision        : 2.2 (pvr 0039 0202)
> 
> timebase        : 199837651
> platform        : pSeries
> machine         : CHRP IBM,8842-21X
> 
> 
> Recently, I discovered that newer kernels would no longer fully boot.
> There's no oops or panic message and they get through most of the kernel
> initialization before simply hanging. I spent some quality time today with
> git-bisect, and traced the badness down to this commit:

I'm just back from vacation and looking into this. 

Ben.
