Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 297D1DDEBB
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Feb 2008 10:11:16 +1100 (EST)
Message-ID: <47BB6209.5080706@freescale.com>
Date: Tue, 19 Feb 2008 17:11:05 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <timur@freescale.com>
Subject: Re: Difference between vmlinux and vmlinux.bin
References: <47BB5D82.6070806@freescale.com>
In-Reply-To: <47BB5D82.6070806@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, lkml <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Timur Tabi wrote:

> So when Kbuild creates vmlinux.bin, what does it do besides extract the PT_LOAD 
> segment?

Never mind, I was doing something stupid which was trashing my in-memory copy of 
vmlinux.bin.

-- 
Timur Tabi
Linux kernel developer at Freescale
