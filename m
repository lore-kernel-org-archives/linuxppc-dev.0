Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe004.messaging.microsoft.com [65.55.88.14])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D1C92B6FAF
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 03:31:09 +1000 (EST)
Message-ID: <4FB535D3.7000106@freescale.com>
Date: Thu, 17 May 2012 12:30:59 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: Re: Build regressions/improvements in v3.4-rc7
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337212281.30558.17.camel@pasglop>
In-Reply-To: <1337212281.30558.17.camel@pasglop>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Parisc List <linux-parisc@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>, linux-kernel@vger.kernel.org,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>,
 Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> Thanks. These are all freescale platforms, the relevant people should be
> already but I've added Scott and Kumar to the CC list just in case.

Seeing how this is my code, I'd say the relevant people were not CC'd. :-)

Anyway, I think I see what the problem is, but it does appear when I use
the normal defconfigs.  What .config was being used?

-- 
Timur Tabi
Linux kernel developer at Freescale
