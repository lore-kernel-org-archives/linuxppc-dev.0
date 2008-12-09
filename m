Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 6EA72DDEFB
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Dec 2008 02:17:01 +1100 (EST)
Message-ID: <493E8BE2.809@freescale.com>
Date: Tue, 09 Dec 2008 09:16:50 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Guillaume Knispel <gknispel@proformatique.com>
Subject: Re: [PATCH] Fix corruption error in rh_alloc_fixed()
References: <20081209152834.1d6ff291@xilun.lan.proformatique.com>	<493E88B7.5020702@freescale.com>
	<20081209161422.5e289e6c@xilun.lan.proformatique.com>
In-Reply-To: <20081209161422.5e289e6c@xilun.lan.proformatique.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, Pantelis Antoniou <pantelis@embeddedalley.com>,
	Li Yang <leoli@freescale.com>,
	Joakim Tjernlund <joakim.tjernlund@transmode.se>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Guillaume Knispel wrote:

> blk = NULL; at the end of the loop is what is done in the more used
> rh_alloc_align(), so for consistency either we change both or we use
> the same construction here.
> I also think that testing for &info->free_list is harder to understand
> because you must have the linked list implementation in your head
> (which a kernel developer should anyway so this is not so important)

Fair enough.

Acked-by: Timur Tabi <timur@freescale.com>

-- 
Timur Tabi
Linux kernel developer at Freescale
