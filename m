Return-Path: <B04825@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7BB05B6EFF
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jun 2010 02:26:42 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	o5GGQenw020327
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 09:26:40 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5GGaVdt000117
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jun 2010 11:36:31 -0500 (CDT)
Message-ID: <4C18FB3F.4020705@freescale.com>
Date: Wed, 16 Jun 2010 11:26:39 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Anatolij Gustschin <agust@denx.de>
Subject: Re: [PATCH 0/5] Rework MPC5121 DIU support (for 2.6.35)
References: <1272584978-19063-1-git-send-email-agust@denx.de>	<y2med82fe3e1004291839m92dea081o6a46dc307e07c4ad@mail.gmail.com>	<20100601113801.5b0ff773@wker>	<AANLkTims596hCnLgN5Po6nS1bRFxKywEDlBA4mlreciV@mail.gmail.com>	<20100616093805.3a8df747@wker>	<4C18F0E4.90309@freescale.com>
	<20100616174714.74a2e110@mw.dip.t-dialin.net>
In-Reply-To: <20100616174714.74a2e110@mw.dip.t-dialin.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-fbdev@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, yorksun@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Anatolij Gustschin wrote:
> On Wed, 16 Jun 2010 10:42:28 -0500
> Timur Tabi <timur@freescale.com> wrote:
> 
>> Anatolij Gustschin wrote:
>>
>>> Any chance this could be done soon? I'd like to include the
>>> MPC5121e DIU support in 2.6.36 since it is currently broken in
>>> mainline and the patches provide the fix.
>>
>> Ok, I'll try it today.
> 
> Thanks!

I tried to build this, but it wouldn't compile, and then I realized I also
need the 11 patches of the set "Update support for MPC512x".  Unfortunately,
I don't have this set in my inbox.

Can you email me, perhaps in one tarball, all of the patches I need?
