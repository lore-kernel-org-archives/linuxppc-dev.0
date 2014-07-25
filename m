Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0212.outbound.protection.outlook.com [207.46.163.212])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDE6C1A06B5
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Jul 2014 05:55:06 +1000 (EST)
Message-ID: <1406318092.29414.116.camel@snotra.buserror.net>
Subject: Re: [PATCH v2 1/7] dt: Introduce the FMan 10 Gb/s MDIO binding
From: Scott Wood <scottwood@freescale.com>
To: Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>
Date: Fri, 25 Jul 2014 14:54:52 -0500
In-Reply-To: <df68a97dc8ae427f95078082ad587543@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1405541831-1277-1-git-send-email-Shruti@Freescale.com>
 <df68a97dc8ae427f95078082ad587543@DM2PR0301MB0864.namprd03.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Kanetkar Shruti-B44454 <Shruti@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2014-07-24 at 22:11 -0500, Xie Shaohui-B21989 wrote:
> Hello, Scott, Shruti,
> 
> There are two types MDIO controllers, each MAC has a corresponding MDIO
> controller to access internal PHYs inside Serdes, another is dedicated
> MDIO controller to access external PHYs (PHYs on board or riser card,
> etc). Current MDIO driver does not distinguish the two controllers, if
> we need to distinguish the controllers, what could be the proper way?
> Perhaps a new property is needed in dts?

Are these different programming models, or just two instances of the
same type of device, with different things attached?

-Scott
