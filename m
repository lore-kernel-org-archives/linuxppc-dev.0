Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52273DDEFD
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  4 Mar 2008 01:12:59 +1100 (EST)
Date: Mon, 3 Mar 2008 13:47:00 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Roman Fietze <roman.fietze@telemotive.de>
Subject: Re: I2S driver
Message-ID: <20080303134656.GA25086@sirena.org.uk>
References: <529490.33431.qm@web23110.mail.ird.yahoo.com>
	<200803031340.36665.roman.fietze@telemotive.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200803031340.36665.roman.fietze@telemotive.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, Mar 03, 2008 at 01:40:36PM +0100, Roman Fietze wrote:
> On Monday 03 March 2008 13:08:43 Angelo wrote:

> > I'm working on I2S driver, on MPC5200b board.

> An ALSA sound driver?

> If yes, there are many places where you can find documentation. If
> not, there are still many places where you can find documentation.

> Could you please specify more precisely what you want to do or where
> you are having problems.

If you are working on an audio device in an embedded system you probably
want to use the ALSA SoC subsystem - have a look at
Documentation/sound/alsa/soc and sound/soc for information.  There is a
development git tree for this availiable at:

	git://opensource.wolfsonmicro.com/linux-2.6-asoc
