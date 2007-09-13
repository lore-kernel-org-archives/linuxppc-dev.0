Return-Path: <erik@dd.nec.com.au>
Received: from ns2.nec.com.au (ns2.nec.com.au [147.76.180.2])
	by ozlabs.org (Postfix) with ESMTP id 0281CDDD06
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 18:52:14 +1000 (EST)
Received: from smtp1.nec.com.au (unknown [172.31.8.18])
	by ns2.nec.com.au (Postfix) with ESMTP
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 18:25:51 +1000 (EST)
Received: from bohr.dd.nec.com.au (bohr.dd.nec.com.au [172.31.20.11])
	by deer.dd.nec.com.au (8.12.5/8.12.5/Debian-1) with ESMTP id
	l8D8PowX010611
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Sep 2007 18:25:50 +1000
Received: from dvalin ([172.31.20.70])
	by bohr.dd.nec.com.au (8.12.3/8.12.3/Debian-7.1) with ESMTP id
	l8D8PmkU012801
	for <linuxppc-embedded@ozlabs.org>; Thu, 13 Sep 2007 18:25:50 +1000
Date: Thu, 13 Sep 2007 18:25:58 +1000
To: linuxppc-embedded@ozlabs.org
Subject: Re: Flash on ep8248e standard motherboards
Message-ID: <20070913082558.GB8968@dd.nec.com.au>
References: <bfa0697f0709041108u2c6b719dj600cb2eb25b66a4a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bfa0697f0709041108u2c6b719dj600cb2eb25b66a4a@mail.gmail.com>
From: erik@dd.nec.com.au (Erik Christiansen)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 04, 2007 at 12:08:47PM -0600, Alan Bennett wrote:
> BDI 2000 Config File:
>   ;  initialize - FLASH BR0 & OR0 (64 Mbyte)
>   ;*******************************************
>   WM32    0xf0010100     0xfc001801
>   WM32     0xf0010104     0xfc0008c2
>   [FLASH]
>   CHIPTYPE    MIRRORX16
>   CHIPSIZE    0x2000000
>   BUSWIDTH    16

Having just taken delivery of an ep8248e, I'm surprised that the
supplied flash config is commented out and erroneous:

[FLASH]
;CHIPTYPE    AM29F       ;Flash type (AM29F | AM29BX8 | AM29BX16 | I28BX8 | I28BX16)
;CHIPSIZE    0x200000    ;The size of one flash chip in bytes (e.g. AM29F010 = 0x20000)
;BUSWIDTH    8           ;The width of the flash memory bus in bits (8 | 16 | 32 | 64)
;

Did you start with the Embedded Planet offering, in your current effort
to create a usable config? Is MIRRORX16 more than a guess?

I've found that my flash chips are "spansion GL256N10FFI02", which
AFAICT are S29GL256N10FFI02 from AMD, as we used to know them.
I wonder if S29M32X16 is a likely guess for CHIPTYPE on the card which
has landed in my lap?

Maybe the most important question is: Will a wrong algorithm choice let
the magic smoke out?

Erik
(With just one toenail on the road, so far.)
