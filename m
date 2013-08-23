Return-Path: <B07421@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DB55A2C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 04:04:52 +1000 (EST)
Message-ID: <1377281078.20722.60.camel@snotra.buserror.net>
Subject: Re: P3041 What a new ethernet phy change to the device tree
From: Scott Wood <scottwood@freescale.com>
To: Mercier Ivan <ivan.mercier@gmail.com>
Date: Fri, 23 Aug 2013 13:04:38 -0500
In-Reply-To: <CAMc2ieqb=_8PDMi9QCGxiYDPx2E56F=WFqYzzw5aUicuKDmsTw@mail.gmail.com>
References: <CAMc2ieqb=_8PDMi9QCGxiYDPx2E56F=WFqYzzw5aUicuKDmsTw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2013-08-23 at 17:49 +0200, Mercier Ivan wrote:
> Hi everybody,
> I have 2 boards based on freescale p3041.
> Ethernet works on uboot on the 2 of them but only the eval card
> p3041ds works with linux.
> So i start modifying the device tree on the other card (wp6.dts) and
> now I can see the ethernet device in Linux but I can't configure it.
> 
> root@p3041ds:~# ifconfig fm1-gb3 10.0.0.1
> fsl_dpa ethernet.14 fm1-gb3: Could not connect to PHY
> /localbus@ffe124000/board-control@3,0/mdio-mux-emi1/rgmii-mdio@28/ethernet-phy@1f
> fsl_dpa ethernet.14 fm1-gb3: init_phy() = -19
> ifconfig: SIOCSIFFLAGS: No such device
> 
> It seems to be a phy address misconfiguration on mdio bus but I don't
> exactly know what to change on my device tree.
> Can anyone look at my two device trees?

It sounds like you're using the Freescale SDK rather than the upstream
kernel (there's no datapath support upstream yet).  For SDK support
please contact support@freescale.com or post a question on
https://community.freescale.com/

-Scott
