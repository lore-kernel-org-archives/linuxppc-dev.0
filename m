Return-Path: <smaclennan@pikatech.com>
Received: from yow.seanm.ca (toronto-hs-216-138-233-67.s-ip.magma.ca
	[216.138.233.67]) by ozlabs.org (Postfix) with SMTP id 3C8F3DE2E8
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Apr 2008 03:51:20 +1000 (EST)
Date: Sun, 13 Apr 2008 13:51:17 -0400
From: Sean MacLennan <smaclennan@pikatech.com>
To: Peter Korsgaard <jacmet@sunsite.dk>
Subject: Re: [PATCH 4/5] LED driver
Message-ID: <20080413135117.64a61b32@lappy.seanm.ca>
In-Reply-To: <87hce5zmj5.fsf@macbook.be.48ers.dk>
References: <20080412134831.424480cf@lappy.seanm.ca>
	<20080412141039.25e14fae@lappy.seanm.ca>
	<87r6daym53.fsf@macbook.be.48ers.dk>
	<20080413125119.6bb54a29@lappy.seanm.ca>
	<87hce5zmj5.fsf@macbook.be.48ers.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 13 Apr 2008 19:34:38 +0200
Peter Korsgaard <jacmet@sunsite.dk> wrote:

> I haven't actually used leds-gpio, but it looks so simple that I
> cannot imagine it not working. There also seems to be quite some
> platforms using it, E.G:
> 
> % git grep '"leds-gpio"' arch|wc -l
> 11
> 
> Or are you referring to the status of gpiolib support on powerpc?

Correct. It looks like the gpiolib will go in for 2.6.26 but not ppc44x
support. Which means I wouldn't be able to get warp support in for this
release.

Cheers,
   Sean
