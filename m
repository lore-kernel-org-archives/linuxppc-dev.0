Return-Path: <geoffrey.levand@am.sony.com>
Received: from mail8.fw-bc.sony.com (mail8.fw-bc.sony.com [160.33.98.75])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4FEF867A41
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Apr 2006 01:23:17 +1000 (EST)
Message-ID: <4448F8DB.6050803@am.sony.com>
Date: Fri, 21 Apr 2006 08:23:07 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch] powerpc: move PAGE_SIZE outside #ifdef __KERNEL__
References: <4447C3BA.6050709@am.sony.com>
	<17480.5183.958036.533453@cargo.ozlabs.ibm.com>
In-Reply-To: <17480.5183.958036.533453@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Paul Mackerras wrote:
> Geoff Levand writes:
> 
>> The procps package needs PAGE_SIZE, defined in asm-powerpc/page.h,
> 
> Ummm... why?  If procps is assuming that the page size of the kernel
> it's running on is the same as the page size of the kernel it was
> compiled on, it's broken.  It should be using sysconf(PAGE_SIZE) at
> runtime.


As it turned out, the procps was out of date, and getting the latest
solved the problem.  Sorry for the trouble.

-Geoff
