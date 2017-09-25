Return-Path: <york.sun@nxp.com>
Received: from EUR01-VE1-obe.outbound.protection.outlook.com
 (mail-ve1eur01on0077.outbound.protection.outlook.com [104.47.1.77])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y19wy0P4pzDsN9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Sep 2017 03:26:23 +1000 (AEST)
From: York Sun <york.sun@nxp.com>
To: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Leo Li
 <leoyang.li@nxp.com>
Subject: Re: FSL serial 166550 errata broken?
Date: Mon, 25 Sep 2017 17:26:17 +0000
Message-ID: <VI1PR04MB207821E9B5E0FE0BB629E1FA9A7A0@VI1PR04MB2078.eurprd04.prod.outlook.com>
References: <1506358524.29657.31.camel@infinera.com>
Reply-To: York Sun <york.sun@nxp.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/25/2017 09:55 AM, Joakim Tjernlund wrote:=0A=
> We got some "broken" boards(mpx8321) where UART RX is held low(BREAK)=0A=
> There we get a few:=0A=
>    serial8250: too much work for irq18=0A=
> and the board freezes.=0A=
> =0A=
> Looking inte to driver/CPU there is an errtum(A-004737) w.r.t BREAK handl=
ing=0A=
> and I can see we are hitting the irq function fsl8250_handle_irq() added=
=0A=
> in commit: 9deaa53ac7fa373623123aa4f18828dd62292b1a=0A=
>   "serial: add irq handler for Freescale 16550 errata."=0A=
> For all I can tell this workaround is broken and I cannot figure out why.=
=0A=
> Any pointers?=0A=
> =0A=
=0A=
Jocke,=0A=
=0A=
Did you mean MPC8321?=0A=
=0A=
I personally don't have experience debugging this erratum. Have you =0A=
tried to contact the patch author Paul Gortmaker to see how he managed =0A=
to get it work?=0A=
=0A=
York=0A=
