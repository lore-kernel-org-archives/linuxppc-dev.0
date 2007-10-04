Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7328DDDDF7
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Oct 2007 20:59:55 +1000 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e32.co.us.ibm.com (8.12.11.20060308/8.13.8) with ESMTP id
	l949pPOn018119
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 05:51:25 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v8.5) with ESMTP id
	l94Axpbn464914
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 04:59:51 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l94AxoiC007039
	for <linuxppc-dev@ozlabs.org>; Thu, 4 Oct 2007 04:59:51 -0600
Subject: Re: [PATCH] Don't build arch/powerpc/sysdev/dcr.c for ARCH=ppc kernels
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Grant Likely <grant.likely@secretlab.ca>
In-Reply-To: <20071004044911.30154.23109.stgit@trillian.cg.shawcable.net>
References: <20071004044911.30154.23109.stgit@trillian.cg.shawcable.net>
Content-Type: text/plain
Date: Thu, 04 Oct 2007 05:56:45 -0500
Message-Id: <1191495405.3647.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-10-03 at 22:50 -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> dcr.c is an arch/powerpc only thing.
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
> Ben/Paulus,
> 
> As far as I can tell this is correct.  Having sysdev/dcr.c in the arch/ppc
> build spits out warnings.  Grep doesn't show anything in arch/ppc that
> is using it.

Sorry, no.  The ibm_emac driver uses it, which is arch/ppc.  (Yes, the
old one.)

If there are warnings, let's fix those up.  Perhaps Michael's recent
patches in that area introduced something.

josh
