Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 53A36DE155
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 18:56:20 +1000 (EST)
Date: Tue, 26 Aug 2008 10:56:09 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: =?ISO-8859-1?Q?S=E9bastien_Chr=E9tien?=
	<sebastien.chretien.enseirb@gmail.com>
Subject: Re: initramfs vs initrd
In-Reply-To: <319b0ac50808250837r73d88349p1ecad4214d5f7ae3@mail.gmail.com>
Message-ID: <Pine.LNX.4.64.0808261046320.7597@vixen.sonytel.be>
References: <319b0ac50808250557g4bd1d267t14e3bd8887c76e24@mail.gmail.com>
	<20080825131018.GA4199@yoda.jdub.homelinux.org>
	<319b0ac50808250729i2043c4d6h57577e0a2eda7ed8@mail.gmail.com>
	<319b0ac50808250837r73d88349p1ecad4214d5f7ae3@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1815494733-1219740969=:7597"
Cc: linuxppc-dev@ozlabs.org
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

---584349381-1815494733-1219740969=:7597
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 25 Aug 2008, S閎astien Chr閠ien wrote:
> When the kernel is booting, is it possible to check if the initrd is good ?

Sure, the kernel does some basic checking in init/do_mounts_rd.c.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre Europe
The Corporate Village 路 Da Vincilaan 7-D1 路 B-1935 Zaventem 路 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

A division of Sony Europe (Belgium) N.V.
VAT BE 0413.825.160 路 RPR Brussels
Fortis 路 BIC GEBABEBB 路 IBAN BE41293037680010
---584349381-1815494733-1219740969=:7597--
