Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id 8D9D7DDDDB
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 22:27:41 +1000 (EST)
Date: Tue, 23 Sep 2008 13:07:15 +0100
From: Mark Brown <broonie@sirena.org.uk>
To: Ben Dooks <ben-linux@fluff.org>
Subject: Re: [i2c] [PATCH 2/2] i2c: MPC8349E-mITX Power Management and
	GPIO	expander driver
Message-ID: <20080923120713.GC32245@sirena.org.uk>
References: <20080919180354.GB13899@oksana.dev.rtsoft.ru>
	<20080922224540.GM2716@fluff.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080922224540.GM2716@fluff.org.uk>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 22, 2008 at 11:45:40PM +0100, Ben Dooks wrote:

> I've also a driver for a similar PMU fitted to a number
> of our boards that provides basic gpio (wakeup sources) and some
> minimalist power management (so isn't really fit for regulator
> framwork) and isn't really a gpio chip (so drivers/gpio isn't
> really the place for it either.)

FWIW the regulator framework does have support for representing things
as limited as completely non-controllable regulators so it may still be
worth considering that.  It at least provides a degree of abstraction
for the clients in case they are used with more complex regulators and
would allow integration of your PMU with more complex secondary
regulators.  May not be worth the bother, though.
