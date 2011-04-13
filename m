Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA4A8B6F5D
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 14 Apr 2011 09:21:26 +1000 (EST)
Subject: Re: [regression] 2.6.39-rc[1-3] fail to boot on G5 PowerMac
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: kevin diggs <diggskevin38@gmail.com>
In-Reply-To: <BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
References: <19876.35918.322649.256455@pilspetsen.it.uu.se>
	<1302646173.28876.53.camel@pasglop> <1302652502.28876.76.camel@pasglop>
	<19877.23529.745123.819112@pilspetsen.it.uu.se>
	<1302685102.28876.81.camel@pasglop>
	<BANLkTimc84A8kddarnhvrcab3iKZc0HZAg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 14 Apr 2011 09:21:09 +1000
Message-ID: <1302736869.28876.91.camel@pasglop>
Mime-Version: 1.0
Cc: Mikael Pettersson <mikpe@it.uu.se>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-04-13 at 12:52 -0500, kevin diggs wrote:
> > Actually I do get a crash in X later on... something in the radeon
> DRM
> > interrupt code is getting what looks like a NULL dereference. I'll
> try
> > to dig that one later on. I don't know if it's related to your
> problem
> > at all though.
> >
> In this context, what does 'crash' mean? The X thingy goes down? Or
> the whole OS? 

Depends, with xmon enabled you get into xmon :-) Dunno if the oops is
fatal but it could be.

Cheers,
Ben.
