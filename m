Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5EF89DE999
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 08:28:19 +1000 (EST)
Subject: Re: Efficient memcpy()/memmove() for G2/G3 cores...
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Jander <david.jander@protonic.nl>
In-Reply-To: <200808251506.34450.david.jander@protonic.nl>
References: <200808251131.02071.david.jander@protonic.nl>
	<48B290BA.7060202@genesi-usa.com>
	<200808251506.34450.david.jander@protonic.nl>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 08:28:11 +1000
Message-Id: <1219703291.13162.106.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-25 at 15:06 +0200, David Jander wrote:
> Hi Matt,
> 
> On Monday 25 August 2008 13:00:10 Matt Sealey wrote:
> > The focus has definitely been on VMX but that's not to say lower power
> > processors were forgotten :)
> 
> lower-power (pun intended) is coming strong these days, as energy-efficiency 
> is getteing more important every day. And the MPC5121 is a brand-new embedded 
> processor, that will pop-up in quite a lot devices around you most 
> probably ;-)

It would be useful of somebody interested in getting things things
into glibc did the necessary FSF copyright assignment stuff and worked
toward integrating them.

Ben.
