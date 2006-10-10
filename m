Return-Path: <mel@csn.ul.ie>
Received: from calculon.skynet.ie (calculon.skynet.ie [193.1.99.88])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A17FB679FD
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Oct 2006 19:11:29 +1000 (EST)
Date: Tue, 10 Oct 2006 09:41:49 +0100 (IST)
From: Mel Gorman <mel@csn.ul.ie>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: 2.6.19-rc1: known regressions (v3)
In-Reply-To: <20061010051019.GB3650@stusta.de>
Message-ID: <Pine.LNX.4.64.0610100929350.26920@skynet.skynet.ie>
References: <Pine.LNX.4.64.0610042017340.3952@g5.osdl.org>
	<20061010051019.GB3650@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 10 Oct 2006, Adrian Bunk wrote:

> This email lists some known regressions in 2.6.19-rc1 compared to 2.6.18
> that are not yet fixed Linus' tree.
>
> <snip>
>
> Subject    : doesn't boot on iBook G4
> References : http://lkml.org/lkml/2006/10/5/305
> Submitter  : Andreas Schwab <schwab@suse.de>
> Handled-By : Mel Gorman <mel@skynet.ie>
> Patch      : http://lkml.org/lkml/2006/10/6/80
> Status     : patch available
>

This patch is currently in 2.6.18-rc1-mm1 and is called 
mm-use-symbolic-names-instead-of-indices-for-zone-initialisation.patch .

-- 
Mel Gorman
Part-time Phd Student                          Linux Technology Center
University of Limerick                         IBM Dublin Software Lab
