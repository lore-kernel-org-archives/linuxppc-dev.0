Return-Path: <B04825@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe005.messaging.microsoft.com [216.32.181.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 0BB6AB6F9D
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 04:51:56 +1000 (EST)
Message-ID: <4FB548C2.3070405@freescale.com>
Date: Thu, 17 May 2012 13:51:46 -0500
From: Timur Tabi <b04825@freescale.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Build regressions/improvements in v3.4-rc7
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337212281.30558.17.camel@pasglop> <4FB535D3.7000106@freescale.com>
 <CAOZdJXW2jmFG8hkBRMAsO-CJ3ruMd28LqS0b-BGZTU7FnpRi3Q@mail.gmail.com>
 <CAMuHMdVszy2sk6f045krqr=PPQFnd-GrtJYJMQCCPzkq-65psg@mail.gmail.com>
 <4FB546FB.807@freescale.com> <4FB547F9.7000804@freescale.com>
In-Reply-To: <4FB547F9.7000804@freescale.com>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Parisc List <linux-parisc@vger.kernel.org>,
 the arch/x86 maintainers <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Linuxppc-dev <linuxppc-dev@ozlabs.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood wrote:
> Regardless of the config that shows this, the MSR[GS] check should go
> away.  If you have a /hypervisor node, you already know you're a guest.

Fair enough.

-- 
Timur Tabi
Linux kernel developer at Freescale
