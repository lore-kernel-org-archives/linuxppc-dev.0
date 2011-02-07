Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8D2DB70DE
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 02:21:39 +1100 (EST)
Date: Mon, 7 Feb 2011 15:21:32 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Message-ID: <20110207152132.GM10564@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208011324.d5371c4c.sfr@canb.auug.org.au>
	<20110207141829.GK10564@opensource.wolfsonmicro.com>
	<20110208014432.2c9288e4.sfr@canb.auug.org.au>
	<20110207145031.GL10564@opensource.wolfsonmicro.com>
	<AANLkTikw7j5Q7CGZK=Xbcgubt9LYBGiXf01wQ4nbg8NR@mail.gmail.com>
	<20110208021045.699654ca.sfr@canb.auug.org.au>
	<20110208021916.68b33b37.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110208021916.68b33b37.sfr@canb.auug.org.au>
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	Alan Stern <stern@rowland.harvard.edu>,
	linux-pm@lists.linux-foundation.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Feb 08, 2011 at 02:19:16AM +1100, Stephen Rothwell wrote:

> At least some of the powerpc defconfigs were added with CONFIG_PM
> disabled.  I assume that was on purpose (though it may not have been).

I'd not be so sure - since it's a bool without an explicit default set
Kconfig will default to disabling it and if anything enabling it is the
option that requires special effort.
