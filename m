Return-Path: <B07421@freescale.com>
Received: from VA3EHSOBE005.bigfish.com (va3ehsobe005.messaging.microsoft.com
	[216.32.180.31]) by ozlabs.org (Postfix) with ESMTP id 3AEB1B6EDD
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  9 Sep 2010 08:02:28 +1000 (EST)
Received: from mail48-va3 (localhost.localdomain [127.0.0.1])	by
	mail48-va3-R.bigfish.com (Postfix) with ESMTP id 47D3612E814F	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Sep 2010 22:02:21 +0000 (UTC)
Received: from VA3EHSMHS026.bigfish.com (unknown [10.7.14.248])	by
	mail48-va3.bigfish.com (Postfix) with ESMTP id 1F956890051	for
	<linuxppc-dev@lists.ozlabs.org>; Wed,  8 Sep 2010 22:02:21 +0000 (UTC)
Received: from az33smr02.freescale.net (az33smr02.freescale.net
	[10.64.34.200])	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP
	id o88M25Zw021556	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Sep 2010 15:02:15 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by az33smr02.freescale.net (8.13.1/8.13.0) with ESMTP id
	o88M2BOs029699	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 8 Sep 2010 17:02:11 -0500 (CDT)
Date: Wed, 8 Sep 2010 17:02:03 -0500
From: Scott Wood <scottwood@freescale.com>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH][v2] mpc8308_p1m: support for MPC8308 P1M board
Message-ID: <20100908170203.7cfa76a1@schlenkerla.am.freescale.net>
In-Reply-To: <1283982886-24523-1-git-send-email-yanok@emcraft.com>
References: <20100907152834.1f038f49@schlenkerla.am.freescale.net>
	<1283982886-24523-1-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 8 Sep 2010 23:54:46 +0200
Ilya Yanok <yanok@emcraft.com> wrote:

> +		cpld@2,0 {
> +			compatible = "cpld";
> +			reg = <0x2 0x0 0x8>;
> +			interrupts = <48 0x8>;
> +			interrups-parent = <&ipic>;
> +		};

Sorry, missed this before -- "cpld" is way too generic.  The compatible
should uniquely identify this programming interface (possibly something
like "denx,mpc8308_p1m-cpld").

-Scott
