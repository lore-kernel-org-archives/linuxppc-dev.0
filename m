Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-lb0-f180.google.com (mail-lb0-f180.google.com
 [209.85.217.180])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8EE0E14007D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 21:14:14 +1000 (EST)
Received: by mail-lb0-f180.google.com with SMTP id 10so608863lbg.25
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Apr 2014 04:14:08 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20140423104528.GD30036@e106331-lin.cambridge.arm.com>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-4-git-send-email-leif.lindholm@linaro.org>
 <CAMuHMdXBNWum7UJ95uT2hwTd1b5C8ebF2LQ4T-A+RS80p7MH=A@mail.gmail.com>
 <20140418125924.GF5904@bivouac.eciton.net>
 <20140422133515.E7A0BC40754@trevor.secretlab.ca>
 <20140423104528.GD30036@e106331-lin.cambridge.arm.com>
Date: Wed, 23 Apr 2014 13:14:07 +0200
Message-ID: <CAMuHMdW80dm0smxt84b+qcwPuRkvXpCHxAYyhcLWETWCEQ5Xcg@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: Handle memory@0 node on PPC32 only
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Mark Rutland <mark.rutland@arm.com>
Content-Type: text/plain; charset=UTF-8
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "patches@linaro.org" <patches@linaro.org>, Lee Jones <lee.jones@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Leif Lindholm <leif.lindholm@linaro.org>, Rob Herring <robherring2@gmail.com>,
 Grant Likely <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mark,

On Wed, Apr 23, 2014 at 12:45 PM, Mark Rutland <mark.rutland@arm.com> wrote:
> Does anyone have a LongTrail DT to hand, and if so does the root have a
> compatible string? From grepping through the kernel I could only find a
> model string ("IBM,LongTrail").

It's compatible with "prep":

http://users.telenet.be/geertu/Linux/PPC/root.html

Full tree at:

http://users.telenet.be/geertu/Linux/PPC/DeviceTree.html

Sorry, the HTML version is all I still have.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
