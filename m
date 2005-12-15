Return-Path: <linux-kernel@hansmi.ch>
Received: from hansmi.home.forkbomb.ch (hansmi.home.forkbomb.ch
	[213.144.146.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "hansmi.home.forkbomb.ch",
	Issuer "hansmi.home.forkbomb.ch" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 70AFB68885
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 19:37:16 +1100 (EST)
Date: Thu, 15 Dec 2005 09:37:11 +0100
From: Michael Hanselmann <linux-kernel@hansmi.ch>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Message-ID: <20051215083711.GA29034@hansmi.ch>
References: <20051213223659.GB20017@hansmi.ch>
	<d120d5000512141404wc86331fo124ebd29b713b07e@mail.gmail.com>
	<20051214233108.GA20127@hansmi.ch>
	<200512142243.28390.dtor_core@ameritech.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200512142243.28390.dtor_core@ameritech.net>
Cc: kernel-stuff@comcast.net, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-input@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH 2.6 1/2] usb/input: Add relayfs support to appletouch
	driver
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Dec 14, 2005 at 10:43:27PM -0500, Dmitry Torokhov wrote:
> The adjusted patch is below. I am still not sure if this really should be
> in mainline. Was it ever used?

That patch looks fine for me.

I would like to see it in mainline because it makes debugging and
figuring out new protocols much easier. For example, Apple changed the
protocol with the latest PowerBooks (see the other patch for that). Why
should everyone willing to implement a new protocol rewrite this code?
