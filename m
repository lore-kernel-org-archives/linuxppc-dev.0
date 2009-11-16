Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id F0D49B7063
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Nov 2009 08:00:11 +1100 (EST)
Date: Mon, 16 Nov 2009 15:00:09 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 00/10] Fix 8xx MMU/TLB
Message-ID: <20091116210009.GA5113@loki.buserror.net>
References: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1258304977-11760-1-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Rex Feany <RFeany@mrv.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Nov 15, 2009 at 06:09:27PM +0100, Joakim Tjernlund wrote:
> [I used the wrong branch, this will hopefully not conflict]
> 
> This is hopfully the last iteration of the series.
> Rex & Scott, please test and signoff.
> Changes since last version:
>  - Added mandatory pinning of iTLB
>  - Added "DTLB Miss cleanup"

I still get the EFAULTs.

-Scott
