Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-gg0-f170.google.com (mail-gg0-f170.google.com
 [209.85.161.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 356E42C0102
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2012 05:27:15 +1000 (EST)
Received: by ggnf2 with SMTP id f2so4942630ggn.15
 for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2012 12:27:12 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <4FE4B13E.10709@caviumnetworks.com>
References: <1339962373-3224-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdVfLjgrtWoPpvbLf12+=ApE6W9dNcweqD-_2Benr-D7NQ@mail.gmail.com>
 <20120620152759.2caceb8c.yuasa@linux-mips.org>
 <20120620161249.GB29196@linux-mips.org>
 <4FE4B13E.10709@caviumnetworks.com>
Date: Mon, 16 Jul 2012 21:27:12 +0200
Message-ID: <CAMuHMdXSGgH+M_2+xuzY2t_sGZto24=atv3Kaj+R-dWAUPzW7w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: fix bug.h MIPS build regression
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: David Daney <ddaney@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Cc: Linux MIPS Mailing List <linux-mips@linux-mips.org>,
 Linux-sh list <linux-sh@vger.kernel.org>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Paul Mundt <lethal@linux-sh.org>, Chris Zankel <chris@zankel.net>,
 Yoichi Yuasa <yuasa@linux-mips.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 22, 2012 at 7:54 PM, David Daney <ddaney@caviumnetworks.com> wrote:
> On 06/20/2012 09:12 AM, Ralf Baechle wrote:
>>
>> On Wed, Jun 20, 2012 at 03:27:59PM +0900, Yoichi Yuasa wrote:
>>
>>> Commit: 3777808873b0c49c5cf27e44c948dfb02675d578 breaks all MIPS builds.
>>
>>
>> Thanks, fix applied.
>>
>
> Where was it applied?
>
> It doesn't show up in linux-next for 20120622, which is where it is needed.

It's also desperately needed in mainline for 3.5.

Ralf?

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
