Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0A70DDDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 16:30:36 +1100 (EST)
Subject: Re: [PATCHSET] libata: PATA driver for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Jeff Garzik <jeff@garzik.org>
In-Reply-To: <200702140518.l1E5IoWX010896@toshiba.co.jp>
References: <200701260724.l0Q7OISY027645@toshiba.co.jp>
	<45B9B1CD.4040600@garzik.org>
	<200702140518.l1E5IoWX010896@toshiba.co.jp>
Content-Type: text/plain
Date: Wed, 14 Feb 2007 16:29:57 +1100
Message-Id: <1171430997.20192.136.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: arnd@arndb.de, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org,
	paulus@samba.org, alan@lxorguk.ukuu.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> 2.6.20 has been released and (I think) it is the time of merge-window
> for 2.6.21. I want this patch to be merged at this time.
> Please tell me if there are anything I should do.

FYI, Jeff, we have merged the rest of the celleb platform support in the
2.6.21 merge window, so it would be annoying if that didn't make it
(that and some spidernet fixes).

Ben.
