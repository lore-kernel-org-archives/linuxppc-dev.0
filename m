Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 056D4B7E43
	for <linuxppc-dev@ozlabs.org>; Fri, 14 May 2010 07:46:24 +1000 (EST)
Subject: Re: [PATCH] pte_fsl_booke: fix instruction TLB error permission check
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
References: <1273221514-8683-1-git-send-email-leoli@freescale.com>
	<0710E9DF-66DF-4D24-95DE-A04E6D869826@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 14 May 2010 07:46:12 +1000
Message-ID: <1273787172.21352.198.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jin Qing <b24347@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-05-13 at 14:14 -0500, Kumar Gala wrote:
> On May 7, 2010, at 3:38 AM, Li Yang wrote:
> 
> > Check the user/supervisor execution permission base on the code address.
> > This fixes the following oops on module loading or removing.
> > 
> > Unable to handle kernel paging request for instruction fetch
> > Faulting instruction address: 0xf938d040
> > Oops: Kernel access of bad area, sig: 11 [#1]
> > 
> > Signed-off-by: Li Yang <leoli@freescale.com>
> > Signed-off-by: Jin Qing <b24347@freescale.com>
> > ---
> > arch/powerpc/kernel/head_fsl_booke.S |   13 ++++++++++---
> > 1 files changed, 10 insertions(+), 3 deletions(-)
> 
> applied to merge.
> 
> I've updated the commit message to be a bit more clear on why we need to do this.

Not looking at the code right now ... but do we have the same issue on
64e ?

Cheers,
Ben.
