Return-Path: <rsa@us.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63530DF605
	for <linuxppc-dev@ozlabs.org>; Sat, 23 Aug 2008 03:50:54 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m7MHoXKj011241
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 13:50:33 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m7MHoXeP098908
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 11:50:33 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m7MHoWeq024397
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 11:50:32 -0600
Subject: Re: libfreevec benchmarks
From: "Ryan S. Arnold" <rsa@us.ibm.com>
To: Konstantinos Margaritis <markos@codex.gr>
In-Reply-To: <1219427047.7917.38.camel@localhost>
References: <200808211909.16852.markos@codex.gr>
	<1219427047.7917.38.camel@localhost>
Content-Type: text/plain
Date: Fri, 22 Aug 2008 12:50:29 -0500
Message-Id: <1219427429.7917.40.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: rsa@us.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2008-08-22 at 12:44 -0500, Ryan S. Arnold wrote:
> Today, if glibc is configure with --with-cpu=970 it will actually
> default to the power optimizations for the string routines, as
> indicated
> by the sysdeps/powerpc/powerpc[32|64]/970/Implies files.  It'd be
> worth
> verifying that your baseline glibc runs are against existing optimized
> versions of glibc.  If they're not then this is a fault of the distro
> you're testing on.

I intended to say that "it will actually default to the POWER4
optimizations"

Regards,
Ryan S. Arnold
IBM Linux Technology Center
Linux Toolchain Development
