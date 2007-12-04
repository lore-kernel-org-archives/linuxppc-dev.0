Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D863BDDEC7
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Dec 2007 10:39:05 +1100 (EST)
Message-Id: <CDF55957-23B4-44BD-B6EC-22EE4DFD94A8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20071204222047.GA5771@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [FDT][PATCH] Print out the total size as part of ftdump
Date: Tue, 4 Dec 2007 17:38:50 -0600
References: <Pine.LNX.4.64.0712041032580.29317@blarg.am.freescale.net>
	<20071204222047.GA5771@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 4, 2007, at 4:20 PM, David Gibson wrote:

> On Tue, Dec 04, 2007 at 10:33:20AM -0600, Kumar Gala wrote:
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> You know, the whole batch of fprintf()s of header information in
> dt_from_blob() are really just a debugging hack that uglifies dtc's
> output.  The whole lot could be moved over to ftdump instead, which
> is, after all, *supposed* to be a debugging hack.

Yeah, I realized having a way to dump just the header info was nice.

- k
