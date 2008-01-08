Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 37AE0DDFCA
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 02:29:33 +1100 (EST)
Message-ID: <478396D1.2020806@freescale.com>
Date: Tue, 08 Jan 2008 09:29:21 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH v6] qe: add ability to upload QE firmware
References: <11997441442105-git-send-email-timur@freescale.com>
	<20080108133747.f717e4b4.sfr@canb.auug.org.au>
In-Reply-To: <20080108133747.f717e4b4.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:

> Why not:
> 	const u64 *iprop;
> 	int len;
> 
> 	iprop = of_get_property(fs, "extended-modes", &len);
> 	if (iprop && (len == sizeof(u64))
> 		qe_firmware_info.extended_modes = *iprop;

Actually, I like my way better, because then I don't have to define 'len', and I 
don't have to define two integer property variables one for u32 and one for u64. 
  Besides, now that I'm at version 6, I'd rather not post updates for minor 
stylistic changes.

-- 
Timur Tabi
Linux kernel developer at Freescale
