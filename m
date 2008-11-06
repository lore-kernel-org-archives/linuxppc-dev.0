Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1459ADDDE7
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 15:06:00 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mA645PDv007672
	for <linuxppc-dev@ozlabs.org>; Wed, 5 Nov 2008 21:05:46 -0700 (MST)
Message-Id: <90D199EB-E9AA-4B85-87C9-8959C593CB01@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Liu Yu <Yu.Liu@freescale.com>
In-Reply-To: <1225165821-15998-3-git-send-email-yu.liu@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH 2/4] math-emu: Adopt new version of _FP_CHOOSENAN
Date: Wed, 5 Nov 2008 22:05:24 -0600
References: <1225165821-15998-1-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-2-git-send-email-yu.liu@freescale.com>
	<1225165821-15998-3-git-send-email-yu.liu@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 27, 2008, at 10:50 PM, Liu Yu wrote:

> Move to using the same macro definition for _FP_CHOOSENAN as s390,
> sh, sparc32/64.  The original author didn't understand this and
> matched what sparc64 was doing and they have updated to this  
> definition.
>
> Signed-off-by: Liu Yu <yu.liu@freescale.com>
> ---
> arch/powerpc/include/asm/sfp-machine.h |   26 ++++++++++++++++ 
> +---------
> 1 files changed, 17 insertions(+), 9 deletions(-)


applied to next.

- k
