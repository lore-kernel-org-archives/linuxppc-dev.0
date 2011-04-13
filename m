Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2276CB6F1C
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 13 Apr 2011 18:58:32 +1000 (EST)
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Mikael Pettersson <mikpe@it.uu.se>
In-Reply-To: <19877.23529.745123.819112@pilspetsen.it.uu.se>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop> <1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 13 Apr 2011 18:58:22 +1000
Message-ID: <1302685102.28876.81.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-04-13 at 10:16 +0200, Mikael Pettersson wrote:
>  > Ok so on a PowerMac7,3 here (dual 2.5Ghz and mostly same HW or at least
>  > very similar) I can't reproduce your problem with a g5_defconfig.
>  > 
>  > Your config doesn't work well for me (I don't do modules, I netboot),
>  > but after adding a few things to it, it seems to work fine as well. I
>  > added radeonfb and the radeon DRM (not KMS) and I added eventfd, timerfd
>  > and input events.
>  > 
>  > So I'm afraid I'm going to need you to bisect that one to find out what
>  > exact change caused the breakage for you.
> 
> Thanks for checking.  I'll try a bisect later today. 

Actually I do get a crash in X later on... something in the radeon DRM
interrupt code is getting what looks like a NULL dereference. I'll try
to dig that one later on. I don't know if it's related to your problem
at all though.

Cheers,
Ben.
