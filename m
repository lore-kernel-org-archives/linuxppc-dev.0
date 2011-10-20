Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 5401FB70FE
 for <linuxppc-dev@ozlabs.org>; Fri, 21 Oct 2011 03:28:46 +1100 (EST)
From: Tabi Timur-B04825 <B04825@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 2/2] powerpc/85xx: Introduce a P1020 SoC device tree
Date: Thu, 20 Oct 2011 16:28:13 +0000
Message-ID: <CAOZdJXU4uHSTRD0vf2jS9gOzjVyO4BLn9=kEmLwwb72LhkTz=w@mail.gmail.com>
References: <1319095467-6229-1-git-send-email-galak@kernel.crashing.org>
 <1319095467-6229-2-git-send-email-galak@kernel.crashing.org>
In-Reply-To: <1319095467-6229-2-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "devicetree-discuss@lists.ozlabs.org" <devicetree-discuss@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 20, 2011 at 2:24 AM, Kumar Gala <galak@kernel.crashing.org> wro=
te:
>
> =A0arch/powerpc/boot/dts/p1020soc.dtsi | =A0262 +++++++++++++++++++++++++=
++++++++++

All of the other dtsi files are of the format "___si.dtsi".  Why does
this one use "___soc.dtsi"?

--=20
Timur Tabi
Linux kernel developer at Freescale=
