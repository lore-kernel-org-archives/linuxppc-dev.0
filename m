Return-Path: <markn@au1.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp09.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E2D02B7CD7
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 17:21:22 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp09.au.ibm.com (8.14.3/8.13.1) with ESMTP id o1B6LMEn029020
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 17:21:22 +1100
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o1B6GDNP1699954
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 17:16:13 +1100
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
	by d23av02.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	o1B6LLtc026109
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Feb 2010 17:21:21 +1100
From: Mark Nelson <markn@au1.ibm.com>
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH] powerpc: pair loads and stores in copy_4k_page
Date: Thu, 11 Feb 2010 17:25:01 +1100
References: <20100211040754.GH3399@kryten>
In-Reply-To: <20100211040754.GH3399@kryten>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201002111725.01330.markn@au1.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Anton,

On Thursday 11 February 2010 15:07:54 Anton Blanchard wrote:
> 
> A number of our chips like loads and stores to be paired. A small kernel
> module testcase shows the improvement of pairing loads and stores in 
> copy_4k_page:
> 
> POWER6: +9%
> POWER7: +1.5%

I just tried this on one of our QS22 cell blades and it seems to cause
about half a percent speedup but that looks like it's within the noise
of the results that I'm getting.

In any case it doesn't look like it has a negative effect for cell.

Looks good!

Mark
