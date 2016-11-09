Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDXwF6GyPzDvPY
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 04:19:09 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id e187so23064889itc.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Nov 2016 09:19:09 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1626072.dpWPnWgGl9@wuerfel>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <CAMuHMdV4HG0aOr4Qp_OZXU=3jLeOJ2QaMKp09a3v4489ABbRcA@mail.gmail.com>
 <CAMuHMdUmpMpizZpq1V-sLA8Cf2q5oOgOVxGOvKXqTHvn+Mj7Tg@mail.gmail.com>
 <1626072.dpWPnWgGl9@wuerfel>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 9 Nov 2016 18:19:06 +0100
Message-ID: <CAMuHMdVrdjqWruY=dBjWP=jZuZkc=aTBTMijOyTDfZFcaD_jsA@mail.gmail.com>
Subject: Re: [PATCH v2 0/7] soc: renesas: Identify SoC and register with the
 SoC bus
To: Arnd Bergmann <arnd@arndb.de>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Yangbo Lu <yangbo.lu@nxp.com>,
 Simon Horman <horms@verge.net.au>, Magnus Damm <magnus.damm@gmail.com>,
 Rob Herring <robh+dt@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
 Dirk Behme <dirk.behme@de.bosch.com>,
 Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org" <linux-arm-kernel@lists.infradead.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Pankaj Dubey <pankaj.dubey@samsung.com>,
 "linux-samsung-soc@vger.kernel.org" <linux-samsung-soc@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Arnd,

On Wed, Nov 9, 2016 at 5:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, November 9, 2016 2:34:33 PM CET Geert Uytterhoeven wrote:
>> > And Samsung.
>> > Shall I create the immutable branch now?
>>
>> Arnd: are you happy with the new patches and changes?
>
> I still had some comments for patch 7, but that shouldn't stop
> you from creating a branch for the first three so everyone can
> build on top of that.

Thanks!

What about patch [4/7]?
Haven't you received it? Your address was in the To-line for all 7 patches.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
