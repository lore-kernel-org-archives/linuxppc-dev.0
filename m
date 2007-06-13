Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 4A917DDDFD
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Jun 2007 23:43:20 +1000 (EST)
Date: Wed, 13 Jun 2007 15:43:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [patch 29/30] PS3: Device tree source.
In-Reply-To: <184b5119eca8beae9a28453096b6fe26@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0706131542280.20109@pademelon.sonytel.be>
References: <20070612181825.730300780@am.sony.com>>
	<466EEC01.6080807@am.sony.com>
	<f7c4ca74d3e2031e01264f31f09e515a@kernel.crashing.org>
	<20070613084023.GA28629@aepfle.de>
	<0502b4de346bce374f98c49a99be50c1@kernel.crashing.org>
	<20070613112448.GA29239@aepfle.de>
	<184b5119eca8beae9a28453096b6fe26@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-686533106-1181742198=:20109"
Cc: linuxppc-dev@ozlabs.org, Olaf Hering <olaf@aepfle.de>, paulus@samba.org
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

---584337861-686533106-1181742198=:20109
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 13 Jun 2007, Segher Boessenkool wrote:
> >> Please read up on what those properties mean exactly.
> > Yes, do that before the inital release.
> >
> > currently name contains ''
> > currently compatible contains 'PS3PF'
> > currently model contains 'PLAYSTATION 3'
> >
> > Now, do not break the userspace ABI.
> 
> The device tree is not a userspace ABI.  Since
> in this case it is built into the kernel image
> (is it, actually?) there is no breakage between
> firmware and kernel versions, either.

It is built-in for the kboot kernel.
It is passed from the bootstrap to the 2nd stage kernel.

With kind regards,
 
Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Centre Europe
The Corporate Village · Da Vincilaan 7-D1 · B-1930 Zaventem · Belgium
 
Phone:    +32 (0)2 700 8453	
Fax:      +32 (0)2 700 8622	
E-mail:   Geert.Uytterhoeven@sonycom.com	
Internet: http://www.sony-europe.com/
 	
Sony Network and Software Technology Centre Europe	
A division of Sony Service Centre (Europe) N.V.	
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium	
VAT BE 413.825.160 · RPR Brussels	
Fortis Bank Londerzeel IBAN BE39 0013 8235 8619 GEBA-BE-BB	
---584337861-686533106-1181742198=:20109--
