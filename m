Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 640C9B7CF9
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Feb 2010 06:50:36 +1100 (EST)
Date: Fri, 26 Feb 2010 13:50:18 -0600
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 1/4] 8xx: Optimze TLB Miss handlers
Message-ID: <20100226195018.GA26867@loki.buserror.net>
References: <1267172983-28721-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1267172983-28721-2-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 26, 2010 at 09:29:40AM +0100, Joakim Tjernlund wrote:
> This removes a couple of insn's from the TLB Miss
> handlers whithout changing functionality.
> ---

Did a quick test of the patchset, seems to work OK (without CONFIG_SWAP or
CONFIG_MODULES).  Didn't try with CONFIG_8xx_CPU6.

-Scott
