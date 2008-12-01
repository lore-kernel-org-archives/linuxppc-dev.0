Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 61AB9DDDE0
	for <linuxppc-dev@ozlabs.org>; Mon,  1 Dec 2008 22:53:24 +1100 (EST)
Date: Mon, 1 Dec 2008 14:53:20 +0300
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Pierre Ossman <drzeus-mmc@drzeus.cx>
Subject: Re: [PATCH v2] mmc: Add mmc_vddrange_to_ocrmask() helper function
Message-ID: <20081201115320.GA10980@oksana.dev.rtsoft.ru>
References: <20081030195546.GA30645@oksana.dev.rtsoft.ru>
	<20081030195632.GB13640@oksana.dev.rtsoft.ru>
	<20081108215537.12cdf5f6@mjolnir.drzeus.cx>
	<20081126195417.GA26264@oksana.dev.rtsoft.ru>
	<20081130210648.77b8843a@mjolnir.drzeus.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <20081130210648.77b8843a@mjolnir.drzeus.cx>
Cc: linuxppc-dev@ozlabs.org, David Brownell <dbrownell@users.sourceforge.net>,
	linux-kernel@vger.kernel.org
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Nov 30, 2008 at 09:06:48PM +0100, Pierre Ossman wrote:
> On Wed, 26 Nov 2008 22:54:17 +0300
> Anton Vorontsov <avorontsov@ru.mvista.com> wrote:
> 
> > This function sets the OCR mask bits according to provided voltage
> > ranges. Will be used by the mmc_spi OpenFirmware bindings.
> > 
> > Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> > ---
> > 
> > Hi Pierre,
> > 
> > Sorry for the delay.
> > 
> 
> This looks perfect. Just tell me when you want me to queue it up.

I plan resend the series (OF MMC SPI) some time between 2.6.28-rc0
and -rc1, that is, when all needed powerpc patches will be merged
into the Linus' tree.

Though, the $subject patch could be merged anytime as it doesn't
depend on anything else. So, if you'll merge it earlier, that will
make things a bit easier: -1 patch to resend. ;-)

Thanks,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
