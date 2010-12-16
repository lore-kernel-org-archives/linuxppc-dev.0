Return-Path: <B04825@freescale.com>
Received: from VA3EHSOBE001.bigfish.com (va3ehsobe001.messaging.microsoft.com
	[216.32.180.11]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B6A8F1007D6
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Dec 2010 03:55:19 +1100 (EST)
Received: from mail182-va3 (localhost.localdomain [127.0.0.1])	by
	mail182-va3-R.bigfish.com (Postfix) with ESMTP id 9A72D4D820B	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 16:55:15 +0000 (UTC)
Received: from VA3EHSMHS028.bigfish.com (unknown [10.7.14.235])	by
	mail182-va3.bigfish.com (Postfix) with ESMTP id 7CB65290046	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 16:55:15 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	oBGGve1G028306	for
	<linuxppc-dev@ozlabs.org>; Thu, 16 Dec 2010 09:57:40 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	oBGHCUwQ005918	for <linuxppc-dev@ozlabs.org>;
	Thu, 16 Dec 2010 11:12:31 -0600 (CST)
Message-ID: <4D0A446E.5020600@freescale.com>
Date: Thu, 16 Dec 2010 10:55:10 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH v4 5/5] fsl-diu-fb: Support setting display mode using EDID
References: <1279893639-24333-1-git-send-email-agust@denx.de>
	<1279893639-24333-6-git-send-email-agust@denx.de>
	<AANLkTin-TL5_TKnyHYtZdixosfqpkPNoarSTC+K4tTUb@mail.gmail.com>
	<AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
In-Reply-To: <AANLkTi=NwY_gcBXeKXeGX-qist3tMQ4EWqj3twYGfeWD@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	Anatolij Gustschin <agust@denx.de>, devicetree-discuss@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Grant Likely wrote:
> This is for devices which don't have an i2c edid channel.

So are we expecting board-specific code in U-Boot to add the data to the device
tree?

-- 
Timur Tabi
Linux kernel developer at Freescale
