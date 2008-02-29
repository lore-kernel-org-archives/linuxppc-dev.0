Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 7820CDDE9E
	for <linuxppc-dev@ozlabs.org>; Fri, 29 Feb 2008 19:35:52 +1100 (EST)
Date: Fri, 29 Feb 2008 09:35:48 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [dtc] breaking out libfdt from dtc so other progs can use it
In-Reply-To: <20080228125940.78f7f2b6@vader.jdub.homelinux.org>
Message-ID: <Pine.LNX.4.64.0802290930020.25557@vixen.sonytel.be>
References: <1204141243.18831.12.camel@thinkpad.austin.ibm.com>
	<20080228014101.GA24330@localhost.localdomain>
	<1204216244.6676.13.camel@thinkpad.austin.ibm.com>
	<20080228125940.78f7f2b6@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-638510431-1204274148=:25557"
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>, David Gibson <dwg@au1.ibm.com>
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

---584349381-638510431-1204274148=:25557
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 28 Feb 2008, Josh Boyer wrote:
> On Thu, 28 Feb 2008 10:30:44 -0600
> Jerone Young <jyoung5@us.ibm.com> wrote:
> > If it where broken out of dtc it would be easier to pickup and pull
> > fixes from it. Even package it so programs can easily build it
> > standalone.
> 
> That's akin to saying libcrypto should be broken out to be completely
> standalone from openssl.  That doesn't make sense either.

Thanks, your openssl example triggered me posting this reply ;-)

I think people are confusing source and binary packages.

E.g. on Debian, the openssl source package is used to build 3 binary packages:
openssl, libssl0.9.8, and libssl-dev. Hence to install applications that use
libssl, you don't have to install all 3, just libssl0.9.8.

But this doesn't mean libssl is separate from openssl source-wise: both are
build from the same source package.

So the single source package dtc could be packaged as 2 binary packages: dtc
and libfdt.

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
---584349381-638510431-1204274148=:25557--
