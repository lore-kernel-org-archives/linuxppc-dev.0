Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 94BB4DDE1E
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Jul 2007 16:39:37 +1000 (EST)
Date: Wed, 18 Jul 2007 08:39:35 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH 01/61] Use strcasecmp() rather than strncasecmp() when
	determining device node compatibility.
In-Reply-To: <1184723916.1486.10.camel@concordia.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.62.0707180838590.18423@pademelon.sonytel.be>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<1184723916.1486.10.camel@concordia.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-98478038-1184740775=:18423"
Cc: linuxppc-dev@ozlabs.org
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

---584337861-98478038-1184740775=:18423
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Wed, 18 Jul 2007, Michael Ellerman wrote:
> On Tue, 2007-07-17 at 20:31 -0500, Scott Wood wrote:
> > Re: [PATCH 01/61] ....
> 
> That's gotta be close to a record ..

Na, last 2 series from akpm where I was CCed on a few patches had /268 resp.
/234 ;-)

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
---584337861-98478038-1184740775=:18423--
