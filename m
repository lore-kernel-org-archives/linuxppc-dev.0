Return-Path: <jangiels@speakeasy.net>
Received: from mail3.speakeasy.net (mail3.speakeasy.net [216.254.0.203])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C579B2BC0F
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Oct 2004 06:16:01 +1000 (EST)
From: Jeff Angielski <jangiels@speakeasy.net>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <2BE1C900-239D-11D9-9860-003065F9B7DC@embeddededge.com>
References: <A3240F62EF3C2749B1A25D3BC9548F4148BCF1@ExchWENZ02.wenz.global.vpn>
	<721875C6-236D-11D9-9860-003065F9B7DC@embeddededge.com>
	<1098371711.3508.9.camel@nighteyes.localdomain>
	<B9C9EB8C-2378-11D9-9860-003065F9B7DC@embeddededge.com>
	<1098379749.8619.16.camel@nighteyes.localdomain>
	<1098385953.8619.38.camel@nighteyes.localdomain>
	<2BE1C900-239D-11D9-9860-003065F9B7DC@embeddededge.com>
Content-Type: text/plain
Message-Id: <1098389762.8619.43.camel@nighteyes.localdomain>
Mime-Version: 1.0
Date: Thu, 21 Oct 2004 16:16:02 -0400
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: SCC UART -"tx interrupt buffer pointer"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2004-10-21 at 16:09, Dan Malek wrote:
> On Oct 21, 2004, at 3:12 PM, Jeff Angielski wrote:
> 
> > ..... The "Tx interrupt buffer pointer" in the SCC parameter
> > ram was outside the range of valid buffer addresses.
> 
> That's not exactly outside of the range.  It is just one byte past
> the end of the last buffer, which will get reset when it reads
> the first BD.  Don't confuse yourself by looking at that internal
> data.  Without knowledge of the microcode, it can be misleading :-)

Ok.  I thought that might be the case since the manuals say they are to
only be used for debugging.

> 
> > There are 4 buffers starting at: 0x00194284, 0x001942a4, 0x001842c4, 
> > and
> > 0x001842e4.
> 
> I hope these are typos.  The last two should be 0x001942c4, and
> 0x001942e4.  If they aren't, something is really broken.

They are typos - I have been staring at too many hex values lately.  
>From the mem dump you can see the correct values.

Jeff

	
