Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.21])
	by ozlabs.org (Postfix) with SMTP id D29DD67B37
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jun 2006 08:08:52 +1000 (EST)
Date: Thu, 15 Jun 2006 00:08:50 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: [OOPS] 2.6.17-rc3 on an mpc8241
In-Reply-To: <Pine.LNX.4.60.0606142300120.12545@poirot.grange>
Message-ID: <Pine.LNX.4.60.0606150007430.12545@poirot.grange>
References: <Pine.LNX.4.60.0606142245370.12545@poirot.grange>
	<1150318658.13958.26.camel@johannes.berg>
	<Pine.LNX.4.60.0606142300120.12545@poirot.grange>
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

On Wed, 14 Jun 2006, Guennadi Liakhovetski wrote:

> On Wed, 14 Jun 2006, Johannes Berg wrote:
> 
> > On Wed, 2006-06-14 at 22:48 +0200, Guennadi Liakhovetski wrote:
> > > Corrupted stack?...
> > 
> > Looks weird.
> > Enable slab debugging? :)
> 
> Compiling 2.6.17-rc5... And I don't know how easy it is to reproduce... 
> Once I have the kernel ready will try...

Ghm, ok, I know what that was - the very same bug I myself reported 
earlier in asm-offsets... how do you say it in English - twice in the same 
trap?:-)

Thanks
Guennadi
---
Guennadi Liakhovetski
