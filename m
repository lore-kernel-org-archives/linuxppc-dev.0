Return-Path: <jwboyer@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
 [209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 65D48B6F69
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 22:52:46 +1100 (EST)
Received: by vbbfp1 with SMTP id fp1so2353763vbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Dec 2011 03:52:39 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <CAOesGMgkh-OzyRH_O+2TT7AzhY0bHWazua9s6Mj9qmb174DANw@mail.gmail.com>
References: <1322804108.3729.50.camel@pasglop>
 <CAOesGMgkh-OzyRH_O+2TT7AzhY0bHWazua9s6Mj9qmb174DANw@mail.gmail.com>
Date: Fri, 2 Dec 2011 06:52:39 -0500
Message-ID: <CA+5PVA7M3U5y8Ua+2UozOpG4ObcFttNTQO__g_p34swirdgdDg@mail.gmail.com>
Subject: Re: [PATCH] powerpc: Add support for OpenBlockS 600
From: Josh Boyer <jwboyer@gmail.com>
To: Olof Johansson <olof@lixom.net>
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

On Fri, Dec 2, 2011 at 1:40 AM, Olof Johansson <olof@lixom.net> wrote:
> Hi,
>
> On Thu, Dec 1, 2011 at 9:35 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>
>> =A0arch/powerpc/boot/dts/obs600.dts =A0 =A0 =A0 =A0 =A0 | =A0314 +++++++=
+++++++++++++++++++++
>
> It'd be nice to have dtsi files for the SoCs, there's a lot of boiler
> plate in there. That shouldn't hold up this specific patch though.

That sounds like a cleanup project for me.  I just need to figure out
how they work and find time.

>> =A0arch/powerpc/boot/wrapper =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0| =A0 22=
 ++-
>> =A0arch/powerpc/configs/40x/obs600_defconfig =A0| =A0 83 ++++++++
>
> A new single-board defconfig? On arm that is a strong NACK, I'd say
> it's a bad idea on powerpc as well.

I like them.  Particularly when they're the output of savedefconfig.

josh
