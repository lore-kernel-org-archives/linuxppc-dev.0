Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE007.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA18FB6F83
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Jul 2011 05:06:18 +1000 (EST)
Date: Tue, 26 Jul 2011 14:05:54 -0500
From: Scott Wood <scottwood@freescale.com>
To: <MichaelHench@gmail.com>
Subject: Re: [PATCH v2] mtd: eLBC NAND: update ecc_stats.corrected when
	lteccr available
Message-ID: <20110726140554.2096b12d@schlenkerla.am.freescale.net>
In-Reply-To: <CAHyXW604AxBGO=AEAyOcba2VfsjVve+RV7_A8QXaUpJRfAsq3Q@mail.gmail.com>
References: <CAHyXW604AxBGO=AEAyOcba2VfsjVve+RV7_A8QXaUpJRfAsq3Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org, mlcreech@gmail.com,
	mhench@elutions.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 26 Jul 2011 13:59:25 -0500
Michael Hench <michaelhench@gmail.com> wrote:

> update ecc_stats.corrected if LTECCR register is available.
> 
> v2: kernel standard C formatting

Missed a couple:

> +		if(lteccr & 0x000F000F)
> +			out_be32(&lbc->lteccr, 0x000F000F); /* clear lteccr */
> +		if(lteccr & 0x000F0000)
> +			mtd->ecc_stats.corrected++;

-Scott
