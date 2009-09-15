Return-Path: <benh@au1.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id EFAA9B7099
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 15 Sep 2009 10:56:52 +1000 (EST)
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp03.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A1025DDDA0
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:56:51 +1000 (EST)
Received: from d23relay01.au.ibm.com (d23relay01.au.ibm.com [202.81.31.243])
	by e23smtp03.au.ibm.com (8.14.3/8.13.1) with ESMTP id n8F0sOR1028479
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:54:24 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay01.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n8F0un4C323854
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:56:49 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n8F0uml7027220
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Sep 2009 10:56:48 +1000
Subject: Re: [PATCH] powerpc: Fix bug where perf_counters breaks oprofile
From: Benjamin Herrenschmidt <benh@au1.ibm.com>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <20090914204348.GE12372@zod.rchland.ibm.com>
References: <19111.37067.783017.427206@cargo.ozlabs.ibm.com>
	<4AA7AE3B.30809@us.ibm.com> <4AAEA40A.6040701@us.ibm.com>
	<20090914204348.GE12372@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Tue, 15 Sep 2009 10:56:47 +1000
Message-Id: <1252976208.8375.181.camel@pasglop>
Mime-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>, Maynard Johnson <mpjohn@us.ibm.com>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2009-09-14 at 16:43 -0400, Josh Boyer wrote:
> On Mon, Sep 14, 2009 at 03:14:02PM -0500, Maynard Johnson wrote:
> >Maynard Johnson wrote:
> >> Paul Mackerras wrote:
> >>> Currently there is a bug where if you use oprofile on a pSeries
> >>> machine, then use perf_counters, then use oprofile again, oprofile
> >>> will not work correctly; it will lose the PMU configuration the next
> >>> time the hypervisor does a partition context switch, and thereafter
> >>> won't count anything.
> >Ben,
> >Is there any way to get this bug fix into 2.6.31 or is the window closed?  Once the problem occurs, you can't get oprofile to work again without a reboot.  Really would be nice (for many reasons) to get this fixed in .31.
> 
> .31 is already released.  Could probably get it into a -stable .31 kernel
> though.

The fix is already upstream as well no ?

Ben.

> josh
