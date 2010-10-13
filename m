Return-Path: <nacc@us.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id A06CBB70F1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Oct 2010 04:43:34 +1100 (EST)
Received: from d01relay01.pok.ibm.com (d01relay01.pok.ibm.com [9.56.227.233])
	by e4.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id o9DHRYE2023830
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 13:27:34 -0400
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
	by d01relay01.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	o9DHhU3u373966
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 13:43:30 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
	by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
	o9DHhT6x010766
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Oct 2010 13:43:29 -0400
Date: Wed, 13 Oct 2010 10:43:25 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 09/15] ppc/vio: use dma ops helpers
Message-ID: <20101013174325.GA3913@us.ibm.com>
References: <1284573958-8397-1-git-send-email-nacc@us.ibm.com>
	<1284573958-8397-10-git-send-email-nacc@us.ibm.com>
	<AANLkTim2Sie0Hop7Akn2CsSgEMPOdq5kDRcfcnAFtghS@mail.gmail.com>
	<1286945760.2205.0.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286945760.2205.0.camel@pasglop>
Cc: Brian King <brking@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 13.10.2010 [15:56:00 +1100], Benjamin Herrenschmidt wrote:
> On Wed, 2010-09-15 at 12:33 -0600, Grant Likely wrote:
> > On Wed, Sep 15, 2010 at 12:05 PM, Nishanth Aravamudan <nacc@us.ibm.com> wrote:
> > > Use the set_dma_ops helper. Instead of modifying vio_dma_mapping_ops,
> > > just create a trivial wrapper for dma_supported.
> > >
> > > Signed-off-by: Milton Miller <miltonm@bga.com>
> > > Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
> > 
> > Looks right to me.
> 
> I never saw 8/15 btw ... I'm applying up to 7, please resend the rest.

Ah apologies, 8/15 was for microblaze and get_maintainer.pl didn't cc
many of the same folks. Will resend 8-15 and make sure ppc-dev gets
cc'd.

Thanks,
Nish
-- 
Nishanth Aravamudan <nacc@us.ibm.com>
IBM Linux Technology Center
