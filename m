Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8E29BDDEF4
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Sep 2008 07:40:15 +1000 (EST)
Message-ID: <48C59B71.3040902@freescale.com>
Date: Mon, 08 Sep 2008 16:38:57 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: avorontsov@ru.mvista.com
Subject: Re: git apply vs. renamed files index mismatch
References: <1220900995-11928-1-git-send-email-becky.bruce@freescale.com>
	<1220900995-11928-2-git-send-email-becky.bruce@freescale.com>
	<48C57A92.6060608@freescale.com>
	<20080908212717.GA21338@oksana.dev.rtsoft.ru>
In-Reply-To: <20080908212717.GA21338@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: git@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Anton Vorontsov wrote:
> I always thought that posting "-M" patches to the public lists is
> discouraged since it is quite difficult to apply them via patch(1).
> Also think of non-git users...

I think the substantially enhanced reviewability trumps non-git-users 
who can follow the rename instructions manually (or fix up their patch 
utility) if they insist on shunning tools that would make their life easier.

> diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
> new file mode 100644
> index 0000000..ae5708e
> [...]
> diff --git a/arch/powerpc/kernel/dma_64.c b/arch/powerpc/kernel/dma_64.c
> deleted file mode 100644
> index ae5708e..0000000
> 
> That is, if hashes match then it was pure rename.

I suppose, though it's not as easy to spot, and won't help in showing 
what the differences are if there are any.

-Scott
