Return-Path: <daniel.ng1234@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id 20C00DDD04
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Mar 2009 17:49:28 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so560379waf.9
	for <linuxppc-dev@ozlabs.org>; Thu, 26 Mar 2009 23:49:27 -0700 (PDT)
MIME-Version: 1.0
Date: Fri, 27 Mar 2009 17:49:27 +1100
Message-ID: <547eba1b0903262349ne434f33of96c0a31a452f2af@mail.gmail.com>
Subject: How to submit patches?
From: Daniel Ng <daniel.ng1234@gmail.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

What are the current requirements for submitting a patch?

I have created a patch which provides an SPI_LSB_FIRST option for the
SPI Bit-banging driver.

The SPI Bit-banging driver currently only supports MSB-first data
transmission (see include/linux/spi/spi_bitbang.h).

If someone could point me to the relevant, current documentation for
submitting kernel driver patches, I'd be most appreciative.

Cheers,
Daniel
