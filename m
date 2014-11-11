Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [195.58.98.146])
 by lists.ozlabs.org (Postfix) with ESMTP id 1AEAD1A015A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 09:34:09 +1100 (AEDT)
In-Reply-To: <1415727479.15957.29.camel@freescale.com>
References: <1415102196-9238-1-git-send-email-shh.xie@gmail.com>
 <1415665384.15957.16.camel@freescale.com>
 <fb6dc6131da04e89bfc31bd8278030a0@DM2PR0301MB0864.namprd03.prod.outlook.com>
 <1415727479.15957.29.camel@freescale.com>
To: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
Subject: Re: [PATCH] DT: add MDIO node for FMan node
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Message-ID: <OF15DE84DA.A166DEAF-ONC1257D8D.007B1CCE-C1257D8D.007B6562@transmode.se>
Date: Tue, 11 Nov 2014 23:27:47 +0100
Content-Type: text/plain; charset="US-ASCII"
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Xie Shaohui-B21989 <Shaohui.Xie@freescale.com>,
 Medve Emilian-EMMEDVE1 <Emilian.Medve@freescale.com>,
 Liberman Igal-B31950 <Igal.Liberman@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> >
> > The TBI implements transmit/receive portions of PCS, it's not used in
> > Linux. The PCS on Fman V3 are not just for SGMII, it has more
> > implementations, it's used in Linux.

It is used for PHY less mode(aka fixed PHY) and needs to be exposed to
linux so it is possible to select SGMII/1000BASE-X, AutoNeg etc.

> 
> The device tree is about the hardware, not what's used in Linux.
> 
> -Scott
