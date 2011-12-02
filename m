Return-Path: <olof@lixom.net>
Received: from mail-gy0-f179.google.com (mail-gy0-f179.google.com
 [209.85.160.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id AE077B6F18
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 17:40:22 +1100 (EST)
Received: by ghbg15 with SMTP id g15so2883455ghb.38
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Dec 2011 22:40:19 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <1322804108.3729.50.camel@pasglop>
References: <1322804108.3729.50.camel@pasglop>
Date: Thu, 1 Dec 2011 22:40:18 -0800
Message-ID: <CAOesGMgkh-OzyRH_O+2TT7AzhY0bHWazua9s6Mj9qmb174DANw@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add support for OpenBlockS 600
From: Olof Johansson <olof@lixom.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Thu, Dec 1, 2011 at 9:35 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:

> =A0arch/powerpc/boot/dts/obs600.dts =A0 =A0 =A0 =A0 =A0 | =A0314 ++++++++=
++++++++++++++++++++

It'd be nice to have dtsi files for the SoCs, there's a lot of boiler
plate in there. That shouldn't hold up this specific patch though.

> =A0arch/powerpc/boot/wrapper =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 22 =
++-
> =A0arch/powerpc/configs/40x/obs600_defconfig =A0| =A0 83 ++++++++

A new single-board defconfig? On arm that is a strong NACK, I'd say
it's a bad idea on powerpc as well.


-Olof
