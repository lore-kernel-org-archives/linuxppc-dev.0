Return-Path: <dwg@au1.ibm.com>
Received: from e23smtp06.au.ibm.com (E23SMTP06.au.ibm.com [202.81.18.175])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp06.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C34F1DDE1D
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Apr 2008 11:11:37 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp06.au.ibm.com (8.13.1/8.13.1) with ESMTP id m381BC92009344
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 11:11:12 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m381BWhY417918
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 11:11:32 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m381BWxF002411
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Apr 2008 11:11:32 +1000
Date: Tue, 8 Apr 2008 11:11:28 +1000
From: David Gibson <dwg@au1.ibm.com>
To: Hollis Blanchard <hollisb@us.ibm.com>
Subject: Re: [PATCH 2 of 3] [KVM] Add DCR access information to struct kvm_run
Message-ID: <20080408011128.GA13454@localhost.localdomain>
References: <patchbomb.1207601611@localhost.localdomain>
	<474b35009da7b7bdb58c.1207601613@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <474b35009da7b7bdb58c.1207601613@localhost.localdomain>
Cc: kvm-devel@lists.sourceforge.net, linuxppc-dev@ozlabs.org,
	kvm-ppc-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 07, 2008 at 03:53:33PM -0500, Hollis Blanchard wrote:
> 1 file changed, 7 insertions(+)
> include/linux/kvm.h |    7 +++++++
> 
> 
> Device Control Registers are essentially another address space found on PowerPC
> 4xx processors, analogous to PIO on x86. DCRs are always 32 bits, and are
> identified by a 32-bit number.

Well... 10-bit, actually.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
