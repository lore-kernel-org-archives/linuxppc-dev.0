Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5C39FDDFCB
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 22:58:24 +1000 (EST)
Subject: Re: Saving to 32 bits of GPRs in signal context
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Hiroyuki.Mach@gmail.com
In-Reply-To: <feaf5ed90705300548v57bba9c7v157e01c3af07cf9c@mail.gmail.com>
References: <OF462E078D.FFB634FD-ON422572EA.004D1E28-422572EA.004DB265@de.ibm.com>
	<OF611013C9.F9C3C2DB-ON862572EA.0050F570-862572EA.005197A3@us.ibm.com>
	<18012.61822.197988.279764@cargo.ozlabs.ibm.com>
	<ADB2DAF4-B25F-462D-B552-531D706F57BE@kernel.crashing.org>
	<1180525484.19517.266.camel@localhost.localdomain>
	<91D21C34-3D3C-4A1F-9B2E-08F336B7EFC4@kernel.crashing.org>
	<feaf5ed90705300548v57bba9c7v157e01c3af07cf9c@mail.gmail.com>
Content-Type: text/plain
Date: Wed, 30 May 2007 22:58:12 +1000
Message-Id: <1180529892.19517.282.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Ulrich Weigand <Ulrich.Weigand@de.ibm.com>,
	Steve Munroe <sjmunroe@us.ibm.com>,
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

On Wed, 2007-05-30 at 21:48 +0900, Hiroyuki Machida wrote:
> 
> I think same framework as proposed at follwoing URLs,  works.
> http://penguinppc.org/dev/glibc/glibc-powerpc-cpu-addon.html
> http://sources.redhat.com/ml/libc-alpha/2006-01/msg00094.html

Yeah, it would make sense to define a new feature bit to trigger
automatic loading of optimized libs...

Steve, how hard do you think it would be to extend AT_HWCAP ? Like
adding an AT_HWCAP2 or something like that ?

Ben.
