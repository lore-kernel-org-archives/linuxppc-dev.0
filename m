Return-Path: <mohan@in.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e33.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36478DDF30
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 16:01:52 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e33.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id l2751mNF016413
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 00:01:48 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l2751mh2533302
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 22:01:48 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l2751mJI018330
	for <linuxppc-dev@ozlabs.org>; Tue, 6 Mar 2007 22:01:48 -0700
Date: Wed, 7 Mar 2007 10:31:28 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Nathan Lynch <ntl@pobox.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070307050128.GH7476@in.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
	<20070306220546.GI24926@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070306220546.GI24926@localdomain>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 06, 2007 at 04:05:46PM -0600, Nathan Lynch wrote:
> Was the root cause of this problem ever determined?  It sure looked
> like a firmware or hardware problem since it's known to occur only on
> JS20.

When I am trying to boot the kernel with maxcpus=1 from yaboot every
thing works fine. I can recreate this problem only with kexec/kdump
booting. So it may not be a firmware issue.

There may be a problem in the device tree that we pass from first kernel
to kexec'ed kernels?

Regards,
Mohan.
