Return-Path: <broonie@sirena.org.uk>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id E4995B70C5
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 30 Jun 2009 18:59:24 +1000 (EST)
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 79F8ADDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jun 2009 18:59:24 +1000 (EST)
Date: Tue, 30 Jun 2009 09:59:18 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH] alsa/soc: add locking to mpc5200-psc-ac97 driver
Message-ID: <20090630085917.GA13961@sirena.org.uk>
References: <20090629234214.12670.9082.stgit@localhost.localdomain>
	<9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910906291726h5cd5bdf8ve7e946aef855ac07@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 29, 2009 at 08:26:12PM -0400, Jon Smirl wrote:

> Does your touchscreen driver use this mutex? Or was this mutex needed
> just for the AC97 driver?

It's in the register accesses so everything accessing the chip registers
will use it.
