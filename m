Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B79E5DDE00
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 18:54:28 +1100 (EST)
Date: Thu, 27 Mar 2008 00:54:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: York Sun <yorksun@freescale.com>
Subject: Re: [PATCH 1/2 v3] Driver for Freescale 8610 and 5121 DIU
Message-Id: <20080327005403.18d6ab07.akpm@linux-foundation.org>
In-Reply-To: <12064804383051-git-send-email-yorksun@freescale.com>
References: <120648043867-git-send-email-yorksun@freescale.com>
	<12064804383051-git-send-email-yorksun@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-fbdev-devel@lists.sourceforge.net, a.p.zijlstra@chello.nl,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 25 Mar 2008 16:27:17 -0500 York Sun <yorksun@freescale.com> wrote:

> +#if defined(CONFIG_NOT_COHERENT_CACHE)
> +unsigned int *coherence_data;
> +phys_addr_t *coherence_data_phy;
> +#endif

These identifiers are too general for use as global symbols.  I'd suggest
renaming them to diu_coherence_data and diu_coherence_data_phy.  Or make
them static - I didn't check.

I'll duck this version of the patches, as Scott's comments looked rather
substantial.
