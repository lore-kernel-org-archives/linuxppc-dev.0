Return-Path: <jacmet@gmail.com>
Received: from fk-out-0910.google.com (fk-out-0910.google.com [209.85.128.187])
	by ozlabs.org (Postfix) with ESMTP id BDA54DDE09
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Sep 2007 15:33:23 +1000 (EST)
Received: by fk-out-0910.google.com with SMTP id z22so2039065fkz
	for <linuxppc-dev@ozlabs.org>; Mon, 24 Sep 2007 22:33:21 -0700 (PDT)
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [patch 3/3] mpc8349emitx.dts: Add ds1339 RTC
References: <20070920104211.896143373@sunsite.dk>
	<20070920104313.217207466@sunsite.dk>
	<20070920133528.GC14820@ld0162-tx32.am.freescale.net>
	<874pholbdk.fsf@macbook.be.48ers.dk>
	<20070924050709.GM8058@localhost.localdomain>
	<878x6wpq3t.fsf@macbook.be.48ers.dk>
	<20070925021340.GG30338@localhost.localdomain>
From: Peter Korsgaard <jacmet@sunsite.dk>
Date: Tue, 25 Sep 2007 07:33:15 +0200
In-Reply-To: <20070925021340.GG30338@localhost.localdomain> (David Gibson's
	message of "Tue\, 25 Sep 2007 12\:13\:40 +1000")
Message-ID: <87myvbnwbo.fsf@macbook.be.48ers.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: Peter Korsgaard <jacmet@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "David" == David Gibson <david@gibson.dropbear.id.au> writes:

Hi,

 >> The Linux driver for the chip (rtc-1307.c) doesn't expose the NVRAM
 >> bytes either.

 David> Incidentally how are you planning on instantiating the driver?  AFAIK
 David> all the rtc-* drivers are platform drivers rather than of_platform
 David> drivers.  I had been thinking of an rtc helper function that would go
 David> through the tree instantiating platform devices for any RTCs based on
 David> a compatible -> platform device name table.

Please see patch #2 in the series:

http://ozlabs.org/pipermail/linuxppc-dev/2007-September/042896.html

That helper function more or less already exists in fsl_soc.c.

-- 
Bye, Peter Korsgaard
