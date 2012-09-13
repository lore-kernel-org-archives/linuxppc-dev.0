Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-vb0-f42.google.com (mail-vb0-f42.google.com
 [209.85.212.42])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E24102C009A
 for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2012 15:01:33 +1000 (EST)
Received: by vbbfs19 with SMTP id fs19so2636649vbb.15
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2012 22:01:30 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1347494498.2276.19.camel@pasglop>
References: <1347452412-7129-1-git-send-email-dan@danny.cz>
 <1347494498.2276.19.camel@pasglop>
Date: Thu, 13 Sep 2012 07:01:29 +0200
Message-ID: <CAMuHMdU2vahGBej+3Q8eBpmn1c7kU3hb1Ez4hGdY1Upn1qsygQ@mail.gmail.com>
Subject: Re: [PATCH] add GXT4000P and GXT6500P support to the gxt4500 driver
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?Q?Dan_Hor=C3=A1k?= <dan@danny.cz>, linuxppc-dev@ozlabs.org,
 Nico Macrionitis <acrux@cruxppc.org>, Giuseppe Coviello <cjg@cruxppc.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 13, 2012 at 2:01 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Wed, 2012-09-12 at 14:20 +0200, Dan Hor=C3=A1k wrote:
>> I'm reviving an old patch from 2009 that adds support for GXT4000P and G=
XT6500P
>> adapter to the gxt4500 driver.
>
> Who is the original author ?

Signed-off-by: Nico Macrionitis <acrux@cruxppc.org>
Signed-off-by: Giuseppe Coviello <cjg@cruxppc.org>

It even has your ack (albeit not in canonical form ;-), cfr.

>> See threads at http://marc.info/?l=3Dlinux-fbdev-devel&m=3D1243450802169=
52&w=3D2
>> and https://lists.ozlabs.org/pipermail/linuxppc-dev/2009-June/072672.htm=
l
>> for more details.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k=
.org

In personal conversations with technical people, I call myself a hacker. Bu=
t
when I'm talking to journalists I just say "programmer" or something like t=
hat.
                                -- Linus Torvalds
