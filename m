Return-Path: <Geoffrey.Levand@am.sony.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4061B72CA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 02:51:17 +1000 (EST)
Received: from SG2EHSOBE006.bigfish.com (outbound-sin.frontbridge.com
	[207.46.51.80]) by ozlabs.org (Postfix) with ESMTP id 72385DDE07
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 02:51:17 +1000 (EST)
Message-ID: <4A2FE0CA.9070805@am.sony.com>
Date: Wed, 10 Jun 2009 09:35:22 -0700
From: Geoff Levand <geoffrey.levand@am.sony.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH 19/33] ps3: shorten ps3_system_bus_[gs]et_driver_data
	to ps3_system_bus_[gs]et_drvdata
References: <1244644748-24211-1-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-8-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-9-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-10-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-11-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-12-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-13-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-14-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-15-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-16-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-17-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-18-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-19-git-send-email-Geert.Uytterhoeven@sonycom.com>
	<1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
In-Reply-To: <1244644748-24211-20-git-send-email-Geert.Uytterhoeven@sonycom.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: cbe-oss-dev@ozlabs.org, Jim Paris <jim@jtan.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/10/2009 07:38 AM, Geert Uytterhoeven wrote:
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> Cc: Geoff Levand <geoffrey.levand@am.sony.com>
> Cc: Jim Paris <jim@jtan.com>
> ---
>  arch/powerpc/include/asm/ps3.h |    4 +-
>  drivers/block/ps3disk.c        |   23 +++++++-----------
>  drivers/block/ps3vram.c        |   48 ++++++++++++++++++++--------------------
>  drivers/net/ps3_gelic_net.c    |    8 +++---
>  drivers/usb/host/ehci-ps3.c    |    7 ++---
>  drivers/usb/host/ohci-ps3.c    |    7 ++---
>  6 files changed, 45 insertions(+), 52 deletions(-)

Acked-by: Geoff Levand <geoffrey.levand@am.sony.com>
