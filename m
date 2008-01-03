Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 32E71DDE10
	for <linuxppc-dev@ozlabs.org>; Fri,  4 Jan 2008 10:46:11 +1100 (EST)
Message-ID: <477D73B6.1070108@freescale.com>
Date: Thu, 03 Jan 2008 17:45:58 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: jdl@jdl.com
Subject: Re: [PATCH 1/3] Add yyerrorf() for formatted error messages.
References: <20080103234329.GA8441@ld0162-tx32.am.freescale.net>
In-Reply-To: <20080103234329.GA8441@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
>  dtc-parser.y |   16 +++++++++++++---
>  srcpos.h     |    1 +
>  treesource.c |    1 -
>  3 files changed, 14 insertions(+), 4 deletions(-)

I forgot to tag them as such, but these are of course dtc patches and 
not Linux patches.

-Scott
