Return-Path: <robherring2@gmail.com>
Received: from mail-vn0-x230.google.com (mail-vn0-x230.google.com
 [IPv6:2607:f8b0:400c:c0f::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0E0FC1A08B5
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  7 Jun 2015 01:33:21 +1000 (AEST)
Received: by vnbg129 with SMTP id g129so12429504vnb.9
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 06 Jun 2015 08:33:17 -0700 (PDT)
MIME-Version: 1.0
Sender: robherring2@gmail.com
In-Reply-To: <5572D773.1090008@c-s.fr>
References: <5572D773.1090008@c-s.fr>
From: Rob Herring <robh@kernel.org>
Date: Sat, 6 Jun 2015 10:32:56 -0500
Message-ID: <CAL_JsqLRFfjOkzw24EttG4kZtafxki+SgRHXFYoLDfjDBwGmbg@mail.gmail.com>
Subject: Re: [BUG] mpc8323_rdb platform doesn't boot since kernel 3.16
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jun 6, 2015 at 6:20 AM, christophe leroy
<christophe.leroy@c-s.fr> wrote:
> I've got a MPC8323 RDB evaluation platform from freescale
> kernel 4.0 doesn't boot
> kernel 3.16 doesn't boot
> kernel 3.15 boots ok
>
> I disected the issue down to your commit "of/fdt: Convert FDT functions t=
o
> use libfdt" (e6a6928c3ea1d0195ed75a091e345696b916c09b)
>
> Do you have an idea of what the issue could be ?

Is your dtb older version of the dtb format (before 0x10)? libfdt
doesn't work on the older versions.

If not, do you have logs with debug enabled in drivers/of/fdt.c?

Rob

>
> Christophe
>
> ---
> L'absence de virus dans ce courrier =C3=A9lectronique a =C3=A9t=C3=A9 v=
=C3=A9rifi=C3=A9e par le
> logiciel antivirus Avast.
> https://www.avast.com/antivirus
>
