Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 12A1767C18
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Dec 2006 02:42:03 +1100 (EST)
In-Reply-To: <950a36fb0612140241n15ca51e5xb8a9bb98888befb8@mail.gmail.com>
References: <950a36fb0612140241n15ca51e5xb8a9bb98888befb8@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8B63C317-4AC7-421C-8536-B68ED900127A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 2.6.19] enable watchdog device on mpc834x platforms
Date: Thu, 14 Dec 2006 09:41:54 -0600
To: Pieter-Jan Busschaert <pieterjan.busschaert@gmail.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Dec 14, 2006, at 4:41 AM, Pieter-Jan Busschaert wrote:

> This patch adds the watchdog device for all mpc834x platforms. It
> should be used with the mpc83xx_wdt driver which is already present in
> the kernel.
>
> Patch is made against a clean 2.6.19 kernel.
>
> Signed-off-by: Pieter-Jan Busschaert
> <pieterjan.busschaert+ppcembedded@gmail.com>

Two things about this patch:
1. We've actively avoid taking non-bug fix patches to arch/ppc as we  
try to move people over to arch/powerpc.
2. You can't hard code freq in the platform data like that.  It's  
expected to be the bus frequency the device is running at.

- kumar
