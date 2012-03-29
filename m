Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id C1CF6B6EEF
 for <linuxppc-dev@ozlabs.org>; Fri, 30 Mar 2012 08:47:24 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [git pull] Please pull powerpc.git next branch
Date: Thu, 29 Mar 2012 21:47:18 +0000
Message-ID: <CAOZdJXWyfdMX4mxFqeh=gpyorS9E0aFEhXuxzzvZ_uMV5zhc3g@mail.gmail.com>
References: <alpine.LFD.2.02.1203291544170.14273@spiff>
In-Reply-To: <alpine.LFD.2.02.1203291544170.14273@spiff>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 29, 2012 at 3:44 PM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> A few minor bug fixes and missing dts updates for 3.4. =A0There got lost =
in
> the mix. =A0Sorry for the delay

What about my "don't call of_platform_bus_probe() twice" patch?
That's still an important fix for the P1022DS.

--=20
Timur Tabi
Linux kernel developer at Freescale=
