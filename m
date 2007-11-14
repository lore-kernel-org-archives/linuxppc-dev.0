Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6E6EADDE23
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Nov 2007 04:56:37 +1100 (EST)
Date: Wed, 14 Nov 2007 11:56:30 -0600
From: Scott Wood <scottwood@freescale.com>
To: Alan Bennett <embedded@akb.net>
Subject: Re: I2C on mpc8248 / device tree
Message-ID: <20071114175630.GA4547@loki.buserror.net>
References: <bfa0697f0711131539n228f9f21q7b2acc896499b80d@mail.gmail.com>
	<9e4733910711131556r23a38780q39baf15d85c0bd85@mail.gmail.com>
	<bfa0697f0711140731n20ccd8bdme2de6302848f5a4f@mail.gmail.com>
	<9AADA2CE-A7F0-4C88-BFCF-08D6C8DC09E0@kernel.crashing.org>
	<bfa0697f0711140949q4cf92442gcb4c1ecf7592b040@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bfa0697f0711140949q4cf92442gcb4c1ecf7592b040@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 14, 2007 at 10:49:13AM -0700, Alan Bennett wrote:
> ERk.
>   So if I needed to read values from four i2c devices (raw access would be
> fine) and I need to get this working in a few days, how would you suggest I
> proceed?  Kernel = 2.6.23+.
> 
>   Do I need to start from scratch?
> 
>   Start by using Jon's patch  (or are the 5200 i2c and the cpm2 i2c
> completely incompatible?)

Start with the cpm i2c driver that Jochen Friedrich posted to
linuxppc-embedded.

-Scott
