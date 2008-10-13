Return-Path: <hollisb@us.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9B4C5DE194
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 04:29:52 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9DHL4lZ021929
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 13:21:04 -0400
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9DHTlIx171152
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:29:47 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9DHTk3v002851
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 11:29:47 -0600
Subject: Re: [PATCH 2/3] kvmppc: add hypercall infrastructure - guest part v3
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <F51E4B63-C0B1-4394-872E-3C8A3C0C0BB4@kernel.crashing.org>
References: <1221546450-15761-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1221546450-15761-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<F51E4B63-C0B1-4394-872E-3C8A3C0C0BB4@kernel.crashing.org>
Content-Type: text/plain
Date: Mon, 13 Oct 2008 12:29:43 -0500
Message-Id: <1223918983.16033.30.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: kvm-ppc@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-10-13 at 11:42 -0500, Kumar Gala wrote:
> > +
> > +/* Hypercalls use the beat ABI */
> > +#define KVM_HYPERCALL_BIN 0x44000022
> 
> Any reason this isn't 'sc' ?
> 
> Also, can we make this "sc 1" so its works when we have HW hypervisor  
> support?

Actually, it is "sc 1".

Many versions of as (including 2.16.1) don't recognize that instruction.
This is the standard workaround for situations like that.

-- 
Hollis Blanchard
IBM Linux Technology Center
