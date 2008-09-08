Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 60B49DDFB9
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 05:20:00 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw01.freescale.net (8.12.11/az33egw01) with ESMTP id
	m88JJtRF016391
	for <linuxppc-dev@ozlabs.org>; Mon, 8 Sep 2008 12:19:55 -0700 (MST)
Message-ID: <48C57A92.6060608@freescale.com>
Date: Mon, 08 Sep 2008 14:18:42 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Becky Bruce <becky.bruce@freescale.com>
Subject: Re: [PATCH 1/4] POWERPC: Rename dma_64.c to dma.c
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
In-Reply-To: <1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Becky Bruce wrote:
> This is in preparation for the merge of the 32 and 64-bit
> dma code in arch/powerpc.
> 
> Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
> ---
>  arch/powerpc/kernel/Makefile |    2 +-
>  arch/powerpc/kernel/dma.c    |  200 ++++++++++++++++++++++++++++++++++++++++++
>  arch/powerpc/kernel/dma_64.c |  200 ------------------------------------------
>  3 files changed, 201 insertions(+), 201 deletions(-)
>  create mode 100644 arch/powerpc/kernel/dma.c
>  delete mode 100644 arch/powerpc/kernel/dma_64.c

Passing -M to git format-patch makes it much easier to see whether 
anything changed between the old file and the new file.

-Scott
