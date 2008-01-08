Return-Path: <timur@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F046EDDFB3
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 02:28:20 +1100 (EST)
Message-ID: <47839623.4090200@freescale.com>
Date: Tue, 08 Jan 2008 09:26:27 -0600
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

> If you use:
> 	for_each_child_of_node(qe, fw)
> You don't need to initialise 'fw' in its declararion.

I can't find for_each_child_of_node.  It's not in Kumar's for-2.6.25 branch.

> Why not:
> 	const u64 *iprop;
> 	int len;
> 
> 	iprop = of_get_property(fs, "extended-modes", &len);

Ok.

-- 
Timur Tabi
Linux kernel developer at Freescale
