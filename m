Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x243.google.com (mail-it0-x243.google.com
 [IPv6:2607:f8b0:4001:c0b::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tF0Mz0LyWzDvjJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 21:56:15 +1100 (AEDT)
Received: by mail-it0-x243.google.com with SMTP id q124so2628333itd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 02:56:14 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <CAMuHMdWox5ksj1xhJ6_n0wNA9j6veX0AzAE0V9Gs26Kvw5C_sw@mail.gmail.com>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1626072.dpWPnWgGl9@wuerfel>
 <CAMuHMdVrdjqWruY=dBjWP=jZuZkc=aTBTMijOyTDfZFcaD_jsA@mail.gmail.com>
 <6723536.97ljqcB8tS@wuerfel>
 <CAMuHMdWox5ksj1xhJ6_n0wNA9j6veX0AzAE0V9Gs26Kvw5C_sw@mail.gmail.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Nov 2016 11:56:12 +0100
Message-ID: <CAMuHMdWPk7zZKAHtxcYekS2Ot6j+M8dKJuFe87dxc7U6Z4Ti5w@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the
 SoC bus
To: Ulf Hansson <ulf.hansson@linaro.org>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Dirk Behme <dirk.behme@de.bosch.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robh+dt@kernel.org>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>,
 Simon Horman <horms@verge.net.au>,
 Yangbo Lu <yangbo.lu@nxp.com>, Pankaj Dubey <pankaj.dubey@samsung.com>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 Arnd Bergmann <arnd@arndb.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2016 at 10:22 AM, Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
> Thanks, I've created the branch/tag :
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
>     branch soc-device-match
>     signed tag soc-device-match-tag1

Tested by kbuild test robot:

    https://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
 soc-device-match
    da65a1589dacc7ec44ea0557a14d70a39d991f32  base: soc: Provide a
dummy implementation of soc_device_match()
    elapsed time: 101m
    configs tested: 85

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
