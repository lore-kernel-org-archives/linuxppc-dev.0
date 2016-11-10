Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-it0-x242.google.com (mail-it0-x242.google.com
 [IPv6:2607:f8b0:4001:c0b::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tDyHX0Jq3zDvkW
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 20:22:16 +1100 (AEDT)
Received: by mail-it0-x242.google.com with SMTP id q124so2207122itd.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Nov 2016 01:22:15 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <6723536.97ljqcB8tS@wuerfel>
References: <1477913455-5314-1-git-send-email-geert+renesas@glider.be>
 <1626072.dpWPnWgGl9@wuerfel>
 <CAMuHMdVrdjqWruY=dBjWP=jZuZkc=aTBTMijOyTDfZFcaD_jsA@mail.gmail.com>
 <6723536.97ljqcB8tS@wuerfel>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Thu, 10 Nov 2016 10:22:13 +0100
Message-ID: <CAMuHMdWox5ksj1xhJ6_n0wNA9j6veX0AzAE0V9Gs26Kvw5C_sw@mail.gmail.com>
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

Hi Ulf,

On Wed, Nov 9, 2016 at 10:12 PM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Wednesday, November 9, 2016 6:19:06 PM CET Geert Uytterhoeven wrote:
>> On Wed, Nov 9, 2016 at 5:56 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>> > On Wednesday, November 9, 2016 2:34:33 PM CET Geert Uytterhoeven wrote:
>> >> > And Samsung.
>> >> > Shall I create the immutable branch now?
>> >>
>> >> Arnd: are you happy with the new patches and changes?
>> >
>> > I still had some comments for patch 7, but that shouldn't stop
>> > you from creating a branch for the first three so everyone can
>> > build on top of that.
>>
>> Thanks!
>>
>> What about patch [4/7]?
>> Haven't you received it? Your address was in the To-line for all 7 patches.
>
> Ok, I see it now, looks good. That should be included as well then.

Thanks, I've created the branch/tag :

    git://git.kernel.org/pub/scm/linux/kernel/git/geert/renesas-drivers.git
    branch soc-device-match
    signed tag soc-device-match-tag1

In the mean time, Ulf has applied the first two patches to mmc/next, on top
of lots of MMC work :-(

Ulf, as this is not only a dependency for Freescale/NXP (for sdhci-of-esdhc),
but also for Samsung and Renesas, would it still be possible to replace these
two commits

    8b82c17a8ae533d6 base: soc: introduce soc_device_match() interface
    6fa350172b098f0f base: soc: Check for NULL SoC device attributes

by a merge of soc-device-match-tag1?

You can find more info in the full thread at
https://www.spinics.net/lists/devicetree/msg148558.html

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
