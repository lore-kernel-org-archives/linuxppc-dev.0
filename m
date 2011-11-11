Return-Path: <B07421@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe001.messaging.microsoft.com [216.32.181.181])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2FA591007D4
 for <linuxppc-dev@ozlabs.org>; Sat, 12 Nov 2011 02:30:06 +1100 (EST)
Date: Fri, 11 Nov 2011 09:29:57 -0600
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH 08/30] powerpc/85xx: Rework P1020 SoC device tree
Message-ID: <20111111152957.GA14488@schlenkerla.am.freescale.net>
References: <1320941653-29797-4-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-5-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-6-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-7-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-8-git-send-email-galak@kernel.crashing.org>
 <1320941653-29797-9-git-send-email-galak@kernel.crashing.org>
 <20111110180542.GA12203@schlenkerla.am.freescale.net>
 <5561C3BD-B4E5-4D82-84C4-B8715191DDE3@kernel.crashing.org>
 <20111110185818.GB12339@schlenkerla.am.freescale.net>
 <D0E6C17E-B79C-4EE5-ACC9-F46131AB9693@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <D0E6C17E-B79C-4EE5-ACC9-F46131AB9693@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Nov 10, 2011 at 02:27:11PM -0600, Kumar Gala wrote:
> On Nov 10, 2011, at 12:58 PM, Scott Wood wrote:
> > On Thu, Nov 10, 2011 at 12:46:27PM -0600, Kumar Gala wrote:
> >> On Nov 10, 2011, at 12:05 PM, Scott Wood wrote:
> >>> What does the SoC part need to specify that has to override or go within
> >>> something the board specifies?
> >> 
> >> Not sure I follow the question.
> > 
> > My question is, why does the stuff in post need to be in post, versus pre?
> > 
> > Why can't pre define the soc node, and let the board dts set ranges? 
> > Likewise for localbus, pci, etc.
> > 
> > -Scott
> 
> Gotcha, the reason we have -pre and -post is because of how dtc include
> mechanism works.  It builds it's tree in the order things are parsed in
> the file.

That doesn't really answer the question.

> In addition, "labeled nodes" like we have in post for 'soc', 'lbc',
> etc.  have to be defined after they are referenced.

Don't you mean defined before they are referenced?

What's wrong with defining them in pre?

-Scott
