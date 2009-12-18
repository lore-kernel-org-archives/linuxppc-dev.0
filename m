Return-Path: <vitb@kernel.crashing.org>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 0FC15B6F0D
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Dec 2009 17:11:07 +1100 (EST)
Date: Fri, 18 Dec 2009 09:01:05 +0300
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [POWERPC] add U-Boot bootcount driver.
Message-ID: <20091218090105.397e0da9@vitb-lp>
In-Reply-To: <20091216000250.GK9463@yookeroo>
References: <20091216024730.455b90fd@vitb-lp> <20091216000250.GK9463@yookeroo>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[...]
> > bootcount@0x3eb0 {
> >                   device_type = "bootcount";
Clear.

> 
> No device_type.
> 
> >                   compatible = "uboot,bootcount";
> >                   reg = <0x3eb0 0x08>;
> >                  };
> 
> This area should also be in the flattened tree's reserved map.
> 
Can you elaborate this a little bit? I know about the reserved map by
putting -R4 into device tree cmdline which is apparently not enough :)

Thanks,
-Vitaly
