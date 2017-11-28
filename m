Return-Path: <geert.uytterhoeven@gmail.com>
Received: from mail-qk0-x241.google.com (mail-qk0-x241.google.com
 [IPv6:2607:f8b0:400d:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3ymPH60BrwzDr8x
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Nov 2017 00:13:05 +1100 (AEDT)
Received: by mail-qk0-x241.google.com with SMTP id j202so375295qke.10
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Nov 2017 05:13:05 -0800 (PST)
MIME-Version: 1.0
Sender: geert.uytterhoeven@gmail.com
In-Reply-To: <20170821151651.25096-6-robh@kernel.org>
References: <20170821151651.25096-1-robh@kernel.org>
 <20170821151651.25096-6-robh@kernel.org>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Tue, 28 Nov 2017 14:13:02 +0100
Message-ID: <CAMuHMdU-qQWmDi=V-G=r=poQf-F9hqL2SmoKi+SZyUwEj5vBGw@mail.gmail.com>
Subject: Re: [PATCH v2 5/5] of/fdt: only store the device node basename in
 full_name
To: Rob Herring <robh@kernel.org>
Cc: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Frank Rowand <frowand.list@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Rob,

On Mon, Aug 21, 2017 at 5:16 PM, Rob Herring <robh@kernel.org> wrote:
> With dependencies on a statically allocated full path name converted to
> use %pOF format specifier, we can store just the basename of node, and
> the unflattening of the FDT can be simplified.
>
> This commit will affect the remaining users of full_name. After
> analyzing these users, the remaining cases should only change some print
> messages. The main users of full_name are providing a name for struct
> resource. The resource names shouldn't be important other than providing
> /proc/iomem names.

I guess the plan is to get rid in a subsequent step of all calls to kbasename()
on a full name, which is now futile?

Thanks!

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
