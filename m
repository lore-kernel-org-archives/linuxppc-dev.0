Return-Path: <balbir@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (E23SMTP02.au.ibm.com [202.81.18.163])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp02.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D7C62DDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:33:46 +1100 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp02.au.ibm.com (8.13.1/8.13.1) with ESMTP id m0IAXw8i006804
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:33:58 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0IAXjc93838024
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:33:45 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0IAXjwt008226
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 21:33:45 +1100
Date: Fri, 18 Jan 2008 11:11:46 +0530
From: Balbir Singh <balbir@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC (Take 2)
Message-ID: <20080118054146.GA8973@balbir.in.ibm.com>
References: <20071207223714.11448.91386.sendpatchset@balbir-laptop>
	<1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1200634493.7806.0.camel@concordia.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Reply-To: balbir@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Michael Ellerman <michael@ellerman.id.au> [2008-01-18 16:34:53]:

> On Sat, 2007-12-08 at 04:07 +0530, Balbir Singh wrote:
> > Changelog
> > 
> > 1. Get rid of the constant 5 (based on comments from
> >                                 Geert.Uytterhoeven@sonycom.com)
> > 2. Implement suggestions from Olof Johannson
> > 3. Check if cmdline is NULL in fake_numa_create_new_node()
> > 
> > Tested with additional parameters from Olof
> > 
> > numa=debug,fake=
> > numa=foo,fake=bar
> 
> 
> I'm not sure why yet, but git bisect tells me it's this patch that's
> causing the for-2.6.25 tree to explode on boot on cell machines.
>

Hi,

Do you boot with numa=<options> on your machine? Could I have your
machine configuration? Any OOPS/log would be helpful.

-- 
	Warm Regards,
	Balbir Singh
	Linux Technology Center
	IBM, ISTL
