Return-Path: <B04825@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe003.messaging.microsoft.com [65.55.88.13])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id BDD64B707E
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 04:44:18 +1000 (EST)
Message-ID: <4FB546FB.807@freescale.com>
Date: Thu, 17 May 2012 13:44:11 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Build regressions/improvements in v3.4-rc7
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337212281.30558.17.camel@pasglop> <4FB535D3.7000106@freescale.com>
 <CAOZdJXW2jmFG8hkBRMAsO-CJ3ruMd28LqS0b-BGZTU7FnpRi3Q@mail.gmail.com>
 <CAMuHMdVszy2sk6f045krqr=PPQFnd-GrtJYJMQCCPzkq-65psg@mail.gmail.com>
In-Reply-To: <CAMuHMdVszy2sk6f045krqr=PPQFnd-GrtJYJMQCCPzkq-65psg@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> powerpc randconfig

Doesn't this generate a different .config every time it's run?  Do I keep
generating random .config files until the problem shows up?

-- 
Timur Tabi
Linux kernel developer at Freescale
