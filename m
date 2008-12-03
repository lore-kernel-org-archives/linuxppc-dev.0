Return-Path: <mditto@consentry.com>
Received: from tidalnetworks.net (mail.consentry.com [75.35.230.10])
	by ozlabs.org (Postfix) with ESMTP id 2FCB6DDDED
	for <linuxppc-dev@ozlabs.org>; Wed,  3 Dec 2008 13:27:25 +1100 (EST)
Message-ID: <4935EE8B.80708@consentry.com>
Date: Tue, 02 Dec 2008 18:27:23 -0800
From: Mike Ditto <mditto@consentry.com>
MIME-Version: 1.0
To: joakim.tjernlund@transmode.se
Subject: Re: Erratic MPC8248 CPM2 I2C behaviour
References: <mailman.569.1227903153.29923.linuxppc-dev@ozlabs.org>	
	<49347317.5080600@consentry.com>
	<1228207199.9867.69.camel@gentoo-jocke.transmode.se>
In-Reply-To: <1228207199.9867.69.camel@gentoo-jocke.transmode.se>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-i2c@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jocke,

> The I2C_CHIP_ERRATA is mine and refers to mpc8xx, mpc860 in my case. The
> driver was adapted by me some years ago in 2.4 and now someone has
> ported it to 2.6 it seems.

Thanks for the background info.  Any idea which particular errata it
was meant to fix?  I took a quick look at MPC860 errata document and it
seems that CPM5 and CPM6 both suggest this workaround.

I don't think any of the 8xx CPM errata are present on 82xx, but it
would be good to enable the same or similar workaround on CPM2 for
82xx erratum CPM98, probably even when I2C_CHIP_ERRATA is not defined.

					-=] Mike [=-
