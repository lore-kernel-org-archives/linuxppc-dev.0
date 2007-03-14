Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 801A6DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Mar 2007 08:49:03 +1100 (EST)
Message-ID: <45F86DC1.9010804@freescale.com>
Date: Wed, 14 Mar 2007 16:48:49 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 17/19] bootwrapper: compatibility layer for old U-Boots
	(a.k.a. cuImage, cuboot)
References: <20070312204204.GQ28545@ld0162-tx32.am.freescale.net>
	<20070314214805.GA9546@mag.az.mvista.com>
In-Reply-To: <20070314214805.GA9546@mag.az.mvista.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Mark A. Greer wrote:
> Are you sure that '_end' (which is the end of the zImage/cuImage)
> is safe to use?  If the kernel is large enough (e.g., INITRAMFS)
> it will overwrite your dtb when its decompressed and relocated to 0.
> You need to grok the elfheader to figure out where the kernel will end
> and take the max of that and _end.

Wouldn't it overwrite the bootwrapper itself before overwriting the heap?

-Scott
