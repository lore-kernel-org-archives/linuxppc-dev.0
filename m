Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id CB87EDDED8
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Feb 2009 04:24:46 +1100 (EST)
Subject: Re: Regarding irq_of_parse_and_map
From: Jon Loeliger <jdl@freescale.com>
To: Vijay Nikam <vijay.t.nikam@gmail.com>
In-Reply-To: <f234e2140902190351i41f99cbu22c3654eadf03f49@mail.gmail.com>
References: <f234e2140902160355p148c99d1qc2e5b6f6ae9a716f@mail.gmail.com>
	<20090216180857.GA18069@ld0162-tx32.am.freescale.net>
	<f234e2140902170341y31662e8fla8a8cf87473ed419@mail.gmail.com>
	<499AF08B.6010702@freescale.com>
	<f234e2140902180401u40a71642ga4e221f795bc5abd@mail.gmail.com>
	<20090218165724.GA26391@ld0162-tx32.am.freescale.net>
	<f234e2140902190351i41f99cbu22c3654eadf03f49@mail.gmail.com>
Content-Type: text/plain
Date: Thu, 19 Feb 2009 11:24:36 -0600
Message-Id: <1235064276.29088.2.camel@ld0161-tx32>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2009-02-19 at 17:21 +0530, Vijay Nikam wrote:

> Also is it possible to compile device tree on Linux host and genreate
> dtb for powerpc ? ? ? If yes, then how ? ? ? please let me know ...
> thanks ...

Uh, get a copy of the DTC using:

    $ git clone git://git.jdl.com/software/dtc.git
    $ cd dtc
    $ make

HTH,
jdl
