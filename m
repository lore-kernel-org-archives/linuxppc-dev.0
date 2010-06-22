Return-Path: <timur.tabi@gmail.com>
Received: from mail-vw0-f42.google.com (mail-vw0-f42.google.com
	[209.85.212.42]) by ozlabs.org (Postfix) with ESMTP id 3CB6FB6F14
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jun 2010 07:16:13 +1000 (EST)
Received: by vws2 with SMTP id 2so53011vws.15
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jun 2010 14:16:12 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
From: Timur Tabi <timur@freescale.com>
Date: Tue, 22 Jun 2010 11:29:50 -0500
Message-ID: <AANLkTil0-hijJOvosWUEArVUOLDb_kLWIhfflj2C9pIK@mail.gmail.com>
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
To: Anatolij Gustschin <agust@denx.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-fbdev@vger.kernel.org, wd@denx.de, dzu@denx.de,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@ozlabs.org,
	yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 29, 2010 at 6:49 PM, Anatolij Gustschin <agust@denx.de> wrote:
> This patch series rework DIU support patches submitted
> previously. Comments to the previos patch series have
> been addressed, not related changes are dropped and some
> changes are split out to separate patches to simplify
> review. Furthermore a patch has been added to support
> setting display mode using EDID block in the device tree.

All five patches:

Acked-by: Timur Tabi <timur@freescale.com>

Tested on an MPC8610 HPCD.

-- 
Timur Tabi
Linux kernel developer at Freescale
