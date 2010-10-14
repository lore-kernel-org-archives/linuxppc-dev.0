Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 25D0AB70DE
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 01:42:09 +1100 (EST)
Subject: Re: [PATCH] spi/fsl_spi: Fix compile errors when building on ppc64
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20101014141244.GA4312@angua.secretlab.ca>
Date: Thu, 14 Oct 2010 09:41:57 -0500
Message-Id: <867777DE-D6E2-4448-9AD6-D201C77B2260@kernel.crashing.org>
References: <1287064547-8876-1-git-send-email-galak@kernel.crashing.org>
	<20101014141244.GA4312@angua.secretlab.ca>
To: Grant Likely <grant.likely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, spi-devel-general@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 14, 2010, at 9:12 AM, Grant Likely wrote:

> On Thu, Oct 14, 2010 at 08:55:47AM -0500, Kumar Gala wrote:
>> We get the following when building on ppc64 due to lack of include of
>> <asm/io.h>:
> 
> Is this an immediate problem (merge for .36), or is it a linux-next thing?
> 
> g.

.37 / next is fine.

- k
