Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.186]) by ozlabs.org (Postfix) with ESMTP id 75E82DE95C
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 21:47:30 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: Sebastian Siewior <sebastian@breakpoint.cc>
Subject: Re: [RFC] mtd: add OF2PDEV convertor for the NDFC driver
Date: Thu, 21 Aug 2008 13:46:14 +0200
References: <20080820205958.GA13371@www.tglx.de>
	<200808210040.58809.arnd@arndb.de>
	<20080821082805.GA8013@www.tglx.de>
In-Reply-To: <20080821082805.GA8013@www.tglx.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Message-Id: <200808211346.15450.arnd@arndb.de>
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

On Thursday 21 August 2008, Sebastian Siewior wrote:
> Yes, I heard of it. tglx told me that the IP-Core might show up in
> non-IBM HW and it would be better not to drop the platform support.

Thomas, any example of that? I would guess that all powerpc and microblaze
systems would use the of_platform drivers now, so is there any other
architecture that might get an ndfc?

	Arnd <><
