Return-Path: <david-b@pacbell.net>
Received: from smtp111.sbc.mail.mud.yahoo.com (smtp111.sbc.mail.mud.yahoo.com
	[68.142.198.210]) by ozlabs.org (Postfix) with SMTP id E678BDDE17
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 13 Jun 2007 02:28:20 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: spi-devel-general@lists.sourceforge.net
Subject: Re: [spi-devel-general] [PATCH] Simple driver for Xilinx SPI
	controler.
Date: Tue, 12 Jun 2007 09:28:08 -0700
References: <4666BF47.8080103@ru.mvista.com>
	<200706062209.09731.david-b@pacbell.net>
	<466ADC4B.4050806@ru.mvista.com>
In-Reply-To: <466ADC4B.4050806@ru.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200706120928.09176.david-b@pacbell.net>
Cc: Andrei Konovalov <akonovalov@ru.mvista.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Saturday 09 June 2007, Andrei Konovalov wrote:
> The new patch is attached to this message.

Would you send a version that doesn't produce so many
warnings when run against scripts/checkpatch.pl ??

The issues seem to be mostly whitespace and linelength,
so that should be easy.

- Dave
