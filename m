Return-Path: <timur@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 2787FDDED0
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 00:21:26 +1000 (EST)
Message-ID: <4A1BFAA6.60309@freescale.com>
Date: Tue, 26 May 2009 09:20:22 -0500
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V4 1/5] The macro spin_event_timeout() takes a condition
	and timeout value
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905260432xdc9556cp74edc723eafe24f7@mail.gmail.com>
	<alpine.LRH.2.00.0905261348160.4897@vixen.sonytel.be>
	<200905261349.49832.arnd@arndb.de>
In-Reply-To: <200905261349.49832.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>, broonie@sirena.org.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Tuesday 26 May 2009, Geert Uytterhoeven wrote:
>> However, you can still improve useability by making the macro return the rc,
>> instead of letting the caller pass it, cfr. wait_event_timeout() and friends.

I had that originally, but somewhere during the seven revisions of my macro, it got lost.

I'll post a v9 soon.  This version will take 3 parameters and return __ret, so Jon will need to change his code (sorry).

-- 
Timur Tabi
Linux kernel developer at Freescale
