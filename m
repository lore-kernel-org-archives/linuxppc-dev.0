Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 9D3A8DF1AC
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Aug 2008 00:33:27 +1000 (EST)
Date: Thu, 21 Aug 2008 16:33:24 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: "Steven A. Falco" <sfalco@harris.com>
Subject: Re: Strange behavior with I2C on Sequoia board
In-Reply-To: <48AD6D3B.6030701@harris.com>
Message-ID: <Pine.LNX.4.64.0808211630170.20704@vixen.sonytel.be>
References: <48AC84D9.8050809@harris.com>
	<1219279463.26429.35.camel@jdub.homelinux.org>
	<20080820231828.3c22da08@lappy.seanm.ca>
	<200808211151.40499.sr@denx.de>
	<48AD5FD1.1090809@ru.mvista.com> <48AD6D3B.6030701@harris.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-500620412-1219329204=:20704"
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>,
	Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-500620412-1219329204=:20704
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 21 Aug 2008, Steven A. Falco wrote:
> I would like to switch over to using a uImage rather than the cuboot.uImage.

Can you actually boot a plain uImage from U-Boot?

I've just gave it a try.  While arch/powerpc/boot/cuImage.sequoia boots fine,
after `make uImage', I get arch/powerpc/boot/uImage, but it doesn't boot:

| ## Booting image at 00100000 ...
|    Image Name:   Linux-2.6.27-rc4-dirty
|    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
|    Data Size:    1398827 Bytes =  1.3 MB
|    Load Address: 00000000
|    Entry Point:  00000000
|    Verifying Checksum ... OK
|    Uncompressing Kernel Image ... Error: inflate() returned -3
| GUNZIP ERROR - must RESET board to recover
| 
| U-Boot 1.2.0-gc0c292b2 (Jun  5 2007 - 07:16:12)

and I'm back to U-Boot...

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 · RPR Brussels
Fortis · BIC GEBABEBB · IBAN BE41293037680010
---584349381-500620412-1219329204=:20704--
