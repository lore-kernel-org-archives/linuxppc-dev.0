Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
	(ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Microsoft Secure Server Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id D5457B6F86
	for <linuxppc-dev@ozlabs.org>; Wed, 17 Aug 2011 08:40:49 +1000 (EST)
Received: from mail97-ch1 (localhost.localdomain [127.0.0.1])	by
	mail97-ch1-R.bigfish.com (Postfix) with ESMTP id C6311F600F6	for
	<linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 22:40:45 +0000 (UTC)
Received: from CH1EHSMHS010.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.253])	by mail97-ch1.bigfish.com (Postfix) with ESMTP id
	B12EBA4004C
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Aug 2011 22:40:45 +0000 (UTC)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Tabi Timur-B04825 <B04825@freescale.com>
Subject: Re: [PATCH] powerpc/85xx: enable the audio drivers in the defconfigs
Date: Tue, 16 Aug 2011 22:40:44 +0000
Message-ID: <4E4AF1EB.8060004@freescale.com>
References: <1313534167-6698-1-git-send-email-timur@freescale.com>
In-Reply-To: <1313534167-6698-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Timur Tabi wrote:
> Enable the audio drivers in the non-corenet 85xx defconfigs so that audio
> is enabled on the Freescale P1022DS reference board.
>
> Signed-off-by: Timur Tabi<timur@freescale.com>

Ugh, somehow I got my patches criss-crossed.  Ignore this, please.  I'll=20
post a V2 in just a minute.=
