Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 917C6DDE2A
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Jul 2007 06:12:20 +1000 (EST)
Date: Thu, 12 Jul 2007 22:12:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: Tickless Hz/hrtimers/etc. on PowerPC
In-Reply-To: <46968960.6090402@genesi-usa.com>
Message-ID: <Pine.LNX.4.62.0707122211330.25033@pademelon.sonytel.be>
References: <46951C1A.4080001@genesi-usa.com> <8302.1184178785@neuling.org>
	<46955674.9090304@genesi-usa.com> <29941.1184255383@neuling.org>
	<46968960.6090402@genesi-usa.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1997521270-1184271138=:25033"
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, Michael Neuling <mikey@neuling.org>
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

---584337861-1997521270-1184271138=:25033
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Thu, 12 Jul 2007, Matt Sealey wrote:
> Michael Neuling wrote:
> >> And I don't want to run -rt or wireless-dev for the benefit of a single
> >> feature. What I am after is something like Ingo Molnar throws out..
> >> single patches done the old way, not git trees. It's so much easier to
> >> handle and integrate for example into a Gentoo ebuild or to make a
> >> tarball of accumulated patches from a certain release kernel.
> > 
> > I'm sooo with ya.  I like my patches alphabetised, but no one ever does
> > it for me.
> 
> Well my only requirement is numbering them so they patch in order; there
> are some cute little requirements on that, but I'd rather patch the bare
> minimum and bring in as few quirks and new features than just grab an
> entire -rt tree with what amounts to 60 or 70 individual patches and
> start renumbering them.

That's why quilt uses a series file, so the patch names don't have to be
ordered.

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
---584337861-1997521270-1184271138=:25033--
