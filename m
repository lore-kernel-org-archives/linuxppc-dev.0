Return-Path: <mark.rutland@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
 [217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 0AEC01400F9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 20:48:35 +1000 (EST)
Date: Wed, 23 Apr 2014 11:35:36 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Rob Herring <robherring2@gmail.com>, Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH 3/3] of: Handle memory@0 node on PPC32 only
Message-ID: <20140423103536.GC30036@e106331-lin.cambridge.arm.com>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-4-git-send-email-leif.lindholm@linaro.org>
 <CAMuHMdXBNWum7UJ95uT2hwTd1b5C8ebF2LQ4T-A+RS80p7MH=A@mail.gmail.com>
 <20140418125924.GF5904@bivouac.eciton.net>
 <CAL_JsqJTMWKh3gsv0TnRap82+7BM4XaT4ZAWkQmyfvzTqOq12g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAL_JsqJTMWKh3gsv0TnRap82+7BM4XaT4ZAWkQmyfvzTqOq12g@mail.gmail.com>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Linaro Patches <patches@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leif Lindholm <leif.lindholm@linaro.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 "grant.likely@linaro.org" <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

> > diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
> > index 889005f..230c747 100644
> > --- a/drivers/of/Kconfig
> > +++ b/drivers/of/Kconfig
> > @@ -77,4 +77,7 @@ config OF_RESERVED_MEM
> >         help
> >           Helpers to allow for reservation of memory regions
> >
> > +config OF_MEMORY_AT_0_QUIRK
> > +       def_bool n
> 
> I do not like this because it would not scale to many quirks. As I
> said,, my preference here would be to just add a WARN.

I would very much like to be able to remove the quirk entirely for arm64
if possible, which would require more than the addition of a WARN.

> The other option is get approval to break compatibility on the ST
> platform. It may not be a concern on certain platforms.

Lee, would you be able to provide an answer either way so we can get
the discussion moving?

Cheers,
Mark.
