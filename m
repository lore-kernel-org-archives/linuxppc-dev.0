Return-Path: <sam@ravnborg.org>
Received: from pasmtpB.tele.dk (pasmtpb.tele.dk [80.160.77.98])
	by ozlabs.org (Postfix) with ESMTP id 91DB0DDF90
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 00:59:05 +1000 (EST)
Date: Fri, 27 Jun 2008 15:55:52 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Adrian Bunk <bunk@kernel.org>
Subject: Re: [PATCH 48/60] microblaze_v4: headers simple files - empty or
	redirect to asm-generic
Message-ID: <20080627135552.GA16485@uranus.ravnborg.org>
References: <1214483429-32360-1-git-send-email-monstr@seznam.cz>
	<200806261838.33787.arnd@arndb.de>
	<20080626180530.GA22827@cs181140183.pp.htv.fi>
	<200806270123.06669.arnd@arndb.de>
	<20080627115936.GA18644@cs181140183.pp.htv.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080627115936.GA18644@cs181140183.pp.htv.fi>
Cc: linux-arch@vger.kernel.org, alan@lxorguk.ukuu.org.uk,
	Michal Simek <monstr@monstr.eu>, vapier.adi@gmail.com,
	Arnd Bergmann <arnd@arndb.de>, matthew@wil.cx,
	microblaze-uclinux@itee.uq.edu.au, linux-kernel@vger.kernel.org,
	drepper@redhat.com, linuxppc-dev@ozlabs.org,
	will.newton@gmail.com, hpa@zytor.com, monstr@seznam.cz,
	John.Linn@xilinx.com, john.williams@petalogix.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> 
> We need either all architectures changed or none at all - we do need the 
> arch headers to become more similar, not more different.
> 
> And this is why we need an agreement _before_ an asm-generic header gets 
> added, not after it.
We already have the agreement..
Files which are equal among archs should be in asm-generic.
And there is simply no gain in adding files for an arch when can put
them in asm-generic.
When they are in asm-generic than we can fix the other archs one-by-one.

	Sam
