Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 3CC65B6F9D
 for <linuxppc-dev@ozlabs.org>; Fri, 18 May 2012 04:48:37 +1000 (EST)
Message-ID: <4FB547F9.7000804@freescale.com>
Date: Thu, 17 May 2012 13:48:25 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Timur Tabi <b04825@freescale.com>
Subject: Re: Build regressions/improvements in v3.4-rc7
References: <1337157034-22773-1-git-send-email-geert@linux-m68k.org>
 <CAMuHMdUtL4_mv-e-EQAZmNcb9dAT=PXB59i7Vuj2vf8NnaBFzQ@mail.gmail.com>
 <1337212281.30558.17.camel@pasglop> <4FB535D3.7000106@freescale.com>
 <CAOZdJXW2jmFG8hkBRMAsO-CJ3ruMd28LqS0b-BGZTU7FnpRi3Q@mail.gmail.com>
 <CAMuHMdVszy2sk6f045krqr=PPQFnd-GrtJYJMQCCPzkq-65psg@mail.gmail.com>
 <4FB546FB.807@freescale.com>
In-Reply-To: <4FB546FB.807@freescale.com>
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

On 05/17/2012 01:44 PM, Timur Tabi wrote:
> Geert Uytterhoeven wrote:
>> powerpc randconfig
> 
> Doesn't this generate a different .config every time it's run?  Do I keep
> generating random .config files until the problem shows up?
> 

Regardless of the config that shows this, the MSR[GS] check should go
away.  If you have a /hypervisor node, you already know you're a guest.

-Scott
