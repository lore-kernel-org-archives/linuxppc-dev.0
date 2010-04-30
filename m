Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f181.google.com (mail-iw0-f181.google.com
	[209.85.223.181]) by ozlabs.org (Postfix) with ESMTP id 4E80FB6EEB
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Apr 2010 11:39:50 +1000 (EST)
Received: by iwn11 with SMTP id 11so12486754iwn.11
	for <linuxppc-dev@ozlabs.org>; Thu, 29 Apr 2010 18:39:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1272584978-19063-1-git-send-email-agust@denx.de>
References: <1272584978-19063-1-git-send-email-agust@denx.de>
From: Timur Tabi <timur.tabi@gmail.com>
Date: Thu, 29 Apr 2010 20:39:02 -0500
Message-ID: <y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>
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

Have you tested these changes on an MPC8610 HPCD?  If not, do you
think your changes will break that platform?

I have an 8610 in-house, but I'm currently working on another issue on
that board, so I can't test these patches for you just yet.

-- 
Timur Tabi
Linux kernel developer at Freescale
