Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 907C1B7D8B
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 01:42:33 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5GFgU2N025884
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 08:42:30 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id o5GFsOAd018525
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 10:54:24 -0500 (CDT)
Message-ID: <4C18F0E4.90309@freescale.com>
Date: Wed, 16 Jun 2010 10:42:28 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
References: <1272584978-19063-1-git-send-email-agust@denx.de>	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>	<20100601113801.5b0ff773@wker>	<AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV@mail.gmail.com>
	<20100616093805.3a8df747@wker>
In-Reply-To: <20100616093805.3a8df747@wker>
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

Anatolij Gustschin wrote:

> Any chance this could be done soon? I'd like to include the MPC5121e DIU
> support in 2.6.36 since it is currently broken in mainline and the patches
> provide the fix.

Ok, I'll try it today.
