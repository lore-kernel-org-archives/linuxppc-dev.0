Return-Path: <ntl@pobox.com>
Received: from lollipop.listbox.com (lollipop.listbox.com [208.210.124.78])
	by ozlabs.org (Postfix) with ESMTP id F0CE8DDE43
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Mar 2007 09:21:21 +1100 (EST)
Received: from sceptre.pobox.com (sceptre.pobox.com [207.106.133.20])
	by lollipop.listbox.com (Postfix) with ESMTP id 18682412DA5
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Mar 2007 17:06:20 -0500 (EST)
Date: Tue, 6 Mar 2007 16:05:46 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Mohan Kumar M <mohan@in.ibm.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070306220546.GI24926@localdomain>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070306135754.GB7476@in.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mohan Kumar M wrote:
> Hi,
> 
> Here comes the revised version of patch to fix the interrupt missing
> problem when a kdump kernel is booted with "maxcpus=1" kernel parameter.
> 
> In the xics initialization code a check is made to detemine whether
> maxcpus kernel parameter is present and if its present then
> default_distrib_server variable is initialized to the current boot cpu
> id (by default_server variable). So that when ever a kernel is booted
> with maxcpus kernel parameter all interrupts are routed to the boot cpu
> only.
> 
> Tested on POWER5 and JS20 systems.
> 
> Any comment?

Was the root cause of this problem ever determined?  It sure looked
like a firmware or hardware problem since it's known to occur only on
JS20.
