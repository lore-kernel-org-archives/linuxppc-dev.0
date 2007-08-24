Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 7E628DDEBB
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Aug 2007 17:24:38 +1000 (EST)
Date: Fri, 24 Aug 2007 09:24:36 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: asm-ppc header issues when building ARCH=powerpc
In-Reply-To: <9185AE94-7B04-4DC7-8B9D-C92D13AC6D6F@kernel.crashing.org>
Message-ID: <Pine.LNX.4.62.0708240923520.19123@pademelon.sonytel.be>
References: <75EDD900-3B5E-4D08-9311-13B6510EDE6E@kernel.crashing.org>
	<2F7E4C06-9AC3-458A-B1E3-CA6E0BDD189A@kernel.crashing.org>
	<20070823033318.GJ7042@localhost.localdomain>
	<F19C9986-9E53-47F3-835D-C93DA9C3ADED@kernel.crashing.org>
	<20070823185632.GA3571@cynthia.pants.nu>
	<Pine.LNX.4.62.0708240909370.19123@pademelon.sonytel.be>
	<9185AE94-7B04-4DC7-8B9D-C92D13AC6D6F@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-782885298-1187940276=:19123"
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
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

---584337861-782885298-1187940276=:19123
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 24 Aug 2007, Kumar Gala wrote:
> On Aug 24, 2007, at 2:10 AM, Geert Uytterhoeven wrote:
> > On Thu, 23 Aug 2007, Brad Boyer wrote:
> > > Just as an extra note, the file drivers/macintosh/adb-iop.c is m68k only,
> > > so you should probably leave that alone as well. It probably doesn't need
> > > that header, but the change should really come from the 68k side of
> > > things.
> > 
> > Thanks, it's indeed not needed.
> 
> If its ok that the removal comes from my patchset that would be great.  I'm
> tired of re-spinning these patches at this point ;)

Sure, less work for me! ;-)

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>

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
---584337861-782885298-1187940276=:19123--
