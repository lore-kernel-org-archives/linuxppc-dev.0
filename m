Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de", Issuer "scram e.V. CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3ABA2DDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  3 Feb 2008 07:36:47 +1100 (EST)
Message-ID: <47A4D45E.6030701@scram.de>
Date: Sat, 02 Feb 2008 21:36:46 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: rmcguire@videopresence.com
Subject: Re: 83xx HDLC Driver Dev - Multiple PHYs?
References: <mailman.1.1201309203.24413.linuxppc-embedded@ozlabs.org>
	<000601c85fc5$41e48330$6405a8c0@absolut>
	<D71D9F25-4724-487E-AD07-E848B4608B97@freescale.com>
	<000001c862fe$5ff16550$6405a8c0@absolut>
In-Reply-To: <000001c862fe$5ff16550$6405a8c0@absolut>
Content-Type: text/plain; charset=ISO-8859-1
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

Hi Russell,

> I am putting support for multiple PHY's into the HDLC driver, but after
> converting it to use the of_device tree, and inserting a UCC@5000 for a
> single UCC HDLC driver, it occurred to me that if I insert more devices
> (UCC@6000, UCC@7000, UCC@8000) that the driver will attempt to load multiple
> times.

The module should only be loaded once. If the driver attempts to load multiple
times, this looks like a userscpace bug.

Thanks,
Jochen
