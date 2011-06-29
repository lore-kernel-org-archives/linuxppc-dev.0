Return-Path: <dedekind1@gmail.com>
Received: from mail-pv0-f170.google.com (mail-pv0-f170.google.com
	[74.125.83.170]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 64344B6F75
	for <linuxppc-dev@ozlabs.org>; Wed, 29 Jun 2011 16:21:17 +1000 (EST)
Received: by pvh10 with SMTP id 10so636342pvh.15
	for <linuxppc-dev@ozlabs.org>; Tue, 28 Jun 2011 23:21:14 -0700 (PDT)
Subject: Re: [PATCH 2/2] mtd/nand : workaround for Freescale FCM to support
	large-page Nand chip
From: Artem Bityutskiy <dedekind1@gmail.com>
To: b35362@freescale.com
Date: Wed, 29 Jun 2011 09:22:04 +0300
In-Reply-To: <1309225852-1664-2-git-send-email-b35362@freescale.com>
References: <1309225852-1664-1-git-send-email-b35362@freescale.com>
	<1309225852-1664-2-git-send-email-b35362@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1309328529.23597.106.camel@sauron>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, dwmw2@infradead.org, linux-mtd@lists.infradead.org
Reply-To: dedekind1@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-06-28 at 09:50 +0800, b35362@freescale.com wrote:
> +	/* Hack for supporting the flash chip whose writesize is
> +	 * larger than 2K bytes.
> +	 */

Please, use proper kernel multi-line comments. Please, make sure
checkpatch.pl does not generate 13 errors with this patch.

-- 
Best Regards,
Artem Bityutskiy
