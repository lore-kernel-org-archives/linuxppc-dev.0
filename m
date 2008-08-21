Return-Path: <bigeasy@www.tglx.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 160F7DE69D
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 18:37:53 +1000 (EST)
Date: Thu, 21 Aug 2008 10:28:05 +0200
From: Sebastian Siewior <sebastian@breakpoint.cc>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [RFC] mtd: add OF2PDEV convertor for the NDFC driver
Message-ID: <20080821082805.GA8013@www.tglx.de>
References: <20080820205958.GA13371@www.tglx.de>
	<200808210040.58809.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
In-Reply-To: <200808210040.58809.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, linux-mtd@lists.infradead.org,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

* Arnd Bergmann | 2008-08-21 00:40:58 [+0200]:

>On Wednesday 20 August 2008, Sebastian Siewior wrote:
>> I didn't convert the NDFC driver to support OF because there are
>> non-OF-aware platforms with the ndfc chip.
>> All settings are mandatory except the oob layout.
>
>Are you aware of Sean's patch from
>http://patchwork.ozlabs.org/linuxppc/patch?id=20183 ?

Yes, I heard of it. tglx told me that the IP-Core might show up in
non-IBM HW and it would be better not to drop the platform support.

>	Arnd <><
Sebastian
