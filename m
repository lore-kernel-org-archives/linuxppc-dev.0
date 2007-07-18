Return-Path: <scottwood@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 52F7FDE305
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 02:17:09 +1000 (EST)
Message-ID: <469E3CFE.9020903@freescale.com>
Date: Wed, 18 Jul 2007 11:17:02 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 01/61] Use strcasecmp() rather than strncasecmp() when
	determining device node compatibility.
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<99CD25DB-EAAC-4CF3-AB14-D825AD11E499@kernel.crashing.org>
In-Reply-To: <99CD25DB-EAAC-4CF3-AB14-D825AD11E499@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> Can these patches be broken into logical clumps?

Probably...  I just wanted to get them out there quickly as there've 
been numerous people lately inquiring about 82xx support and posting 
patches.

> Would be easier to review and obviously the fs_enet patches need to  go 
> via jeff and netdev.

While I don't think there'll be a build break if the ethernet patches go 
in separately, there'll be a functional breakage, so I don't want to 
send them to Jeff until I'm confident that the rest of the patches will 
be going in the same release.

-Scott
