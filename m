Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-ie0-x235.google.com (mail-ie0-x235.google.com
 [IPv6:2607:f8b0:4001:c03::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 918F62C009F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 23:05:27 +1100 (EST)
Received: by mail-ie0-f181.google.com with SMTP id 17so10047633iea.26
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Mar 2013 05:05:24 -0700 (PDT)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <1364381223.1345.18.camel@x61.thuisdomein>
References: <1363864206.1390.117.camel@x61.thuisdomein>
 <20130322042159.GC26908@concordia>
 <1364381223.1345.18.camel@x61.thuisdomein>
Date: Wed, 27 Mar 2013 13:05:24 +0100
Message-ID: <CAMuHMdVs-Xxu9e=8WZbTBXE1_+iYOBKODgj9_EKmVbZA3z=8JA@mail.gmail.com>
Subject: Re: [PATCH] powerpc: remove PReP
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: Paul Bolle <pebolle@tiscali.nl>
Content-Type: text/plain; charset=UTF-8
Cc: linux-fbdev@vger.kernel.org,
 Florian Tobias Schandinat <FlorianSchandinat@gmx.de>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Rob Landley <rob@landley.net>,
 Bjorn Helgaas <bhelgaas@google.com>, linuxppc-dev@lists.ozlabs.org,
 Adam Belay <abelay@mit.edu>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 27, 2013 at 11:47 AM, Paul Bolle <pebolle@tiscali.nl> wrote:
> 3) I removed two files in documentation that are almost entirely PReP
> specific. The remaining lines looked uninteresting.

> --- a/Documentation/powerpc/sound.txt
> +++ /dev/null

> -2. IBM CHRP
> -
> -  I have only tested this on the 43P-150.  Build the kernel with the cs4232
> -  set as a module and load the module with irq=9 dma=1 dma2=2 io=0x550

This section is CHRP-specific. The cs4232 driver also worked on the
CHRP LongTrail.
But I don't remember if the parameter values above also applied to LongTrail.
I do remember it didn't work without specifing the right parameters, so you
probably want to keep this section.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
