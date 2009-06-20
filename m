Return-Path: <jochen@scram.de>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id B601FB7125
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun, 21 Jun 2009 03:01:10 +1000 (EST)
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 4414CDDD1B
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Jun 2009 03:01:10 +1000 (EST)
Message-ID: <4A3CF4F3.4030002@scram.de>
Date: Sat, 20 Jun 2009 16:40:51 +0200
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Michael Trimarchi <michael@evidence.eu.com>
Subject: Re: [RFC] Fix stuck on cpm-i2c driver
References: <20090619125002.GA17067@gandalf.sssup.it>
In-Reply-To: <20090619125002.GA17067@gandalf.sssup.it>
Content-Type: text/plain; charset=ISO-8859-1
Cc: bruno@evidence.eu.com, trimarchi@gandalf.sssup.it,
	linux-i2c@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Michael,

> This happen because though the wait_event_interruptible_timeout takes the
> signals into account, the driver does not handle them.
> We propose to change the wait_event_interruptible_timeout with
> wait_event_timeout, leaving the signals to be handled in other points
> on the upper layers.

Makes sense. I2C transactions better shouldn't be interrupted or
data loss might happen.

> Signed-off-by: Bruno Morelli <bruno@evidence.eu.com>
> Signed-off-by: Michael Trimarchi <michael@evidence.eu.com>

Acked-by: Jochen Friedrich <jochen@scram.de>

Thanks,
Jochen
