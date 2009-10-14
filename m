Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 012BAB7B9A
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Oct 2009 03:57:00 +1100 (EST)
Date: Wed, 14 Oct 2009 11:57:23 -0500
From: Scott Wood <scottwood@freescale.com>
To: Joakim Tjernlund <Joakim.Tjernlund@transmode.se>
Subject: Re: [PATCH 2/8] 8xx: Update TLB asm so it behaves as linux mm expects.
Message-ID: <20091014165720.GB21215@loki.buserror.net>
References: <1255278912-8042-1-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-2-git-send-email-Joakim.Tjernlund@transmode.se>
	<1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1255278912-8042-3-git-send-email-Joakim.Tjernlund@transmode.se>
Cc: Rex Feany <RFeany@mrv.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Oct 11, 2009 at 06:35:06PM +0200, Joakim Tjernlund wrote:
> +	mfspr	r11, SRR1
> +	/* clear all error bits as TLB Miss
> +	 * sets a few unconditionally
> +	*/
> +	rlwinm	r11, r11, 0, 0xffff
> +	mtspr	SRR1, r11

arch/powerpc/kernel/head_8xx.S:369: Error: unsupported relocation against SRR1
arch/powerpc/kernel/head_8xx.S:374: Error: unsupported relocation against SRR1

-Scott
