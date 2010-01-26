Return-Path: <david-b@pacbell.net>
Received: from smtp102.sbc.mail.gq1.yahoo.com (smtp102.sbc.mail.gq1.yahoo.com
	[67.195.15.61]) by ozlabs.org (Postfix) with SMTP id 5917A1007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 17:43:08 +1100 (EST)
From: David Brownell <david-b@pacbell.net>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Subject: Re: [PATCH 4/4] powerpc/mcu_mpc8349emitx: Remove OF GPIO handling
	stuff
Date: Mon, 25 Jan 2010 22:43:04 -0800
References: <20100125180957.GA5380@oksana.dev.rtsoft.ru>
	<20100125181114.GD13805@oksana.dev.rtsoft.ru>
In-Reply-To: <20100125181114.GD13805@oksana.dev.rtsoft.ru>
MIME-Version: 1.0
Message-Id: <201001252243.04888.david-b@pacbell.net>
Content-Type: text/plain;
  charset="us-ascii"
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Bill Gatliff <bgat@billgatliff.com>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday 25 January 2010, Anton Vorontsov wrote:
> With the new OF GPIO infrastructure it's much easier to handle I2C
> GPIO controllers, i.e. now drivers don't have to deal with the
> OF-specific bits.

Good, that's how it should have been done in the first place.  :)

Of course, there's still the question of how to get driver-specific
configuration data into the driver...
