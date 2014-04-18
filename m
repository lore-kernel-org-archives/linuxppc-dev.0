Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-la0-f53.google.com (mail-la0-f53.google.com
 [209.85.215.53])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id D45211400EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 23:11:09 +1000 (EST)
Received: by mail-la0-f53.google.com with SMTP id b8so1340536lan.26
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 18 Apr 2014 06:11:04 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20140418125924.GF5904@bivouac.eciton.net>
References: <1397756521-29387-1-git-send-email-leif.lindholm@linaro.org>
 <1397756521-29387-4-git-send-email-leif.lindholm@linaro.org>
 <CAMuHMdXBNWum7UJ95uT2hwTd1b5C8ebF2LQ4T-A+RS80p7MH=A@mail.gmail.com>
 <20140418125924.GF5904@bivouac.eciton.net>
Date: Fri, 18 Apr 2014 15:11:03 +0200
Message-ID: <CAMuHMdUYisn2ejxd_SJ3LDsCgVKkPPT4hgS0-2znm=VFyfMDeQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] of: Handle memory@0 node on PPC32 only
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Leif Lindholm <leif.lindholm@linaro.org>
Content-Type: text/plain; charset=UTF-8
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>, patches@linaro.org,
 Lee Jones <lee.jones@linaro.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Rob Herring <robherring2@gmail.com>, Grant Likely <grant.likely@linaro.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hei Leif,

On Fri, Apr 18, 2014 at 2:59 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
> On Fri, Apr 18, 2014 at 10:04:15AM +0200, Geert Uytterhoeven wrote:
>> On Thu, Apr 17, 2014 at 7:42 PM, Leif Lindholm <leif.lindholm@linaro.org> wrote:
>> > In order to deal with an firmware bug on a specific ppc32 platform
>> > (longtrail), early_init_dt_scan_memory() looks for a node called
>> > memory@0 on all platforms. Restrict this quirk to ppc32 kernels only.
>>
>> This breaks backwards compatibilty with old DTSes (at least on ARM/MIPS,
>> where you added the missing property in patches 1 and 2 of the series)?
>
> As Rob said in response to 0/3, the MIPSs would likely not be affected,
> since they embed the DT.
>
> How about the below v2 3/3 to address the ARM platform?

Looks fine to me, thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
