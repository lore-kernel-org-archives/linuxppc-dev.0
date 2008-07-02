Return-Path: <khali@linux-fr.org>
Date: Wed, 2 Jul 2008 16:36:35 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 1/2] Convert i2c-mpc from a platform driver into  a
	of_platform driver, V4
Message-ID: <20080702163635.127a0a1b@hyperion.delvare>
In-Reply-To: <20080702133343.GC4253@pengutronix.de>
References: <20080630230126.12482.87927.stgit@terra>
	<20080701181444.505c1544@hyperion.delvare>
	<20080702133343.GC4253@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2 Jul 2008 15:33:43 +0200, Wolfram Sang wrote:
> Hi Jean,
> 
> On Tue, Jul 01, 2008 at 06:14:44PM +0200, Jean Delvare wrote:
> 
> > Applied, after fixing the patch so that it applies, fixing it again so
> > that it is correct in the polling case, and fixing it again to make it
> > pass checkpatch.pl.
> So, it cannot be applied directly? :(
> 
> Could you repost the correct version perhaps? I'd like to test it, but
> can't find it at http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/
> (because it is scheduled for 2.6.27?).

It's at:
http://khali.linux-fr.org/devel/linux-2.6/jdelvare-i2c/i2c-mpc-convert-to-an-of_platform-driver.patch

It was simply a couple days since I had updated this public directory,
sorry.

-- 
Jean Delvare
