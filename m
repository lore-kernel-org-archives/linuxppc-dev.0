Return-Path: <B37781@freescale.com>
Received: from TX2EHSOBE005.bigfish.com (tx2ehsobe003.messaging.microsoft.com
 [65.55.88.13]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 51609B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 18:25:21 +1100 (EST)
Subject: Re: [PATCH 1/2 v2] powerpc/85xx: Add dts for P1021RDB-PC board
From: Xu Jiucheng <B37781@freescale.com>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <4F147C49.40008@freescale.com>
References: <1326697208-1519-1-git-send-email-B37781@freescale.com>
 <4F147C49.40008@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 17 Jan 2012 15:30:00 +0800
Message-ID: <1326785400.1964.4.camel@xujc-desktop>
MIME-Version: 1.0
Cc: Matthew McClintock <msm@freescale.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2012-01-16 at 13:36 -0600, Scott Wood wrote:
> On 01/16/2012 01:00 AM, Xu Jiucheng wrote:
> > +	mdio@24000 {
> > +		phy0: ethernet-phy@0 {
> > +			interrupt-parent = <&mpic>;
> > +			interrupts = <3 1>;
> > +			reg = <0x0>;
> > +		};
> > +
> > +		phy1: ethernet-phy@1 {
> > +			interrupt-parent = <&mpic>;
> > +			interrupts = <2 1>;
> > +			reg = <0x1>;
> > +		};
> 
> pq3-mpic.dtsi (included by p1021si-post.dtsi) uses 4-cell interrupt
> specifiers, so they need to be used everywhere.
> 
> -Scott

ok.

Thanks,
Jiucheng
