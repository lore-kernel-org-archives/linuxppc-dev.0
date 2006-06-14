Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id B718667B71
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 08:25:25 +1000 (EST)
Date: Thu, 15 Jun 2006 00:25:23 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [OOPS] 2.6.17-rc3 on an mpc8241
In-Reply-To: <1150323066.13958.28.camel@johannes.berg>
Message-ID: <Pine.LNX.4.60.0606150017380.12545@poirot.grange>
References: <Pine.LNX.4.60.0606142245370.12545@poirot.grange>
	<1150318658.13958.26.camel@johannes.berg>
	<Pine.LNX.4.60.0606142300120.12545@poirot.grange>
	<Pine.LNX.4.60.0606150007430.12545@poirot.grange>
	<1150323066.13958.28.camel@johannes.berg>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 15 Jun 2006, Johannes Berg wrote:

> On Thu, 2006-06-15 at 00:08 +0200, Guennadi Liakhovetski wrote:
> 
> > Ghm, ok, I know what that was - the very same bug I myself reported 
> > earlier in asm-offsets... 
> 
> in asm-offsets? Are you saying that you know what caused this and I
> shouldn't bother looking at it?

As I said - already reported and fixed in 2.6.17-rc6:

From: Linus Torvalds <>
To: Linux Kernel Mailing List <>
Subject: Linux v2.6.17-rc6

...
Paul Mackerras:
      Add CMSPAR to termbits.h for powerpc and alpha
      ppc: Fix typo in TI_LOCAL_FLAGS definition

Thanks
Guennadi
---
Guennadi Liakhovetski
