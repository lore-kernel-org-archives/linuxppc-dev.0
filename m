Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 4073EDDF64
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 21:18:04 +1100 (EST)
Date: Thu, 13 Mar 2008 11:17:51 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: York Sun <yorksun@freescale.com>
Subject: Re: Driver for Freescale Display Interface Unit (A LCD controller)
In-Reply-To: <12053582234100-git-send-email-yorksun@freescale.com>
Message-ID: <Pine.LNX.4.64.0803131117000.9727@vixen.sonytel.be>
References: <12053582234100-git-send-email-yorksun@freescale.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-617900929-1205403461=:9727"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>,
	Linux Kernel Development <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-617900929-1205403461=:9727
Content-Type: TEXT/PLAIN; CHARSET=UTF-8
Content-Transfer-Encoding: 8BIT
Content-ID: <Pine.LNX.4.64.0803131117491.9727@vixen.sonytel.be>

On Wed, 12 Mar 2008, York Sun wrote:
> The following patches are for Freescale DIU. The first patch is a DIU driver.
> The second patch is the platform code to support the driver. It is a frame
> buffer driver for DIU. Descriptions can be found in the patches.
> 
> It is a new feature targeting 2.6.26 kernel.

Please CC linux-fbdev-devel@lists.sourceforge.net when submitting new frame
buffer device drivers. Thx!

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis Bank Zaventem · Swift GEBABEBB08A · IBAN BE39001382358619
---584349381-617900929-1205403461=:9727--
