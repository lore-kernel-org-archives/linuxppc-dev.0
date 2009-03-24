Return-Path: <daniel.ng1234@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id A8730DDE1A
	for <linuxppc-dev@ozlabs.org>; Tue, 24 Mar 2009 16:05:19 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id j37so1460024waf.9
	for <linuxppc-dev@ozlabs.org>; Mon, 23 Mar 2009 22:05:17 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4206182445660643B9AEB8D4E55BBD0A02B9DDEEB4@HERMES2>
References: <547eba1b0903180036m46f6ffc0g521a5081924a2613@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A02B9DDEEB3@HERMES2>
	<547eba1b0903190132pfd11ad5ld4b1bffb6dc22758@mail.gmail.com>
	<547eba1b0903191819v5b03d38ci7a60839873e5bd66@mail.gmail.com>
	<4206182445660643B9AEB8D4E55BBD0A02B9DDEEB4@HERMES2>
Date: Tue, 24 Mar 2009 16:05:17 +1100
Message-ID: <547eba1b0903232205uc3b6a78y6db7e7ce161bd39@mail.gmail.com>
Subject: Re: spidev.c driver on the ppc8247 (kernel 2.6.27.19)
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

The solution is in Documentation/spi/spidev:

-in the slave device spi_board_info struct, specify 'spidev' for the
'modalias' of *every* SPI slave.

I wonder what magic was involved to set this up!!?
