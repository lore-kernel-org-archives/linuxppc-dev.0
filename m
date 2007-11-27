Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 75DE6DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 19:17:19 +1100 (EST)
Date: Tue, 27 Nov 2007 09:17:17 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 2/9] ps3: Use symbolic names for video modes
In-Reply-To: <20071127110538.32f8dfef.sfr@canb.auug.org.au>
Message-ID: <Pine.LNX.4.62.0711270915180.10168@pademelon.sonytel.be>
References: <20071126172455.308741000@pademelon.sonytel.be>
	<20071126172712.128301000@pademelon.sonytel.be>
	<20071127110538.32f8dfef.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-213149330-1196151437=:10168"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Linux Frame Buffer Device Development
	<linux-fbdev-devel@lists.sourceforge.net>
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

---584337861-213149330-1196151437=:10168
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 27 Nov 2007, Stephen Rothwell wrote:
> On Mon, 26 Nov 2007 18:24:57 +0100 Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com> wrote:
> > @@ -594,20 +594,21 @@ static const struct {
> >  	unsigned mask : 19;
> >  	unsigned id :  4;
> >  } ps3av_preferred_modes[] = {
> > -	{ .mask = PS3AV_RESBIT_WUXGA		<< SHIFT_VESA,	.id = 13 },
> > -	{ .mask = PS3AV_RESBIT_1920x1080P	<< SHIFT_60,	.id = 5 },
> > -	{ .mask = PS3AV_RESBIT_1920x1080P	<< SHIFT_50,	.id = 10 },
> > -	{ .mask = PS3AV_RESBIT_1920x1080I	<< SHIFT_60,	.id = 4 },
> > -	{ .mask = PS3AV_RESBIT_1920x1080I	<< SHIFT_50,	.id = 9 },
> > -	{ .mask = PS3AV_RESBIT_SXGA		<< SHIFT_VESA,	.id = 12 },
> > -	{ .mask = PS3AV_RESBIT_WXGA		<< SHIFT_VESA,	.id = 11 },
> > -	{ .mask = PS3AV_RESBIT_1280x720P	<< SHIFT_60,	.id = 3 },
> > -	{ .mask = PS3AV_RESBIT_1280x720P	<< SHIFT_50,	.id = 8 },
> > -	{ .mask = PS3AV_RESBIT_720x480P		<< SHIFT_60,	.id = 2 },
> > -	{ .mask = PS3AV_RESBIT_720x576P		<< SHIFT_50,	.id = 7 },
> > +	{ PS3AV_RESBIT_WUXGA      << SHIFT_VESA, PS3AV_MODE_WUXGA   },
> > +	{ PS3AV_RESBIT_1920x1080P << SHIFT_60,   PS3AV_MODE_1080P60 },
> > +	{ PS3AV_RESBIT_1920x1080P << SHIFT_50,   PS3AV_MODE_1080P50 },
> > +	{ PS3AV_RESBIT_1920x1080I << SHIFT_60,   PS3AV_MODE_1080I60 },
> > +	{ PS3AV_RESBIT_1920x1080I << SHIFT_50,   PS3AV_MODE_1080I50 },
> > +	{ PS3AV_RESBIT_SXGA       << SHIFT_VESA, PS3AV_MODE_SXGA    },
> > +	{ PS3AV_RESBIT_WXGA       << SHIFT_VESA, PS3AV_MODE_WXGA    },
> > +	{ PS3AV_RESBIT_1280x720P  << SHIFT_60,   PS3AV_MODE_720P60  },
> > +	{ PS3AV_RESBIT_1280x720P  << SHIFT_50,   PS3AV_MODE_720P50  },
> > +	{ PS3AV_RESBIT_720x480P   << SHIFT_60,   PS3AV_MODE_480P    },
> > +	{ PS3AV_RESBIT_720x576P   << SHIFT_50,   PS3AV_MODE_576P    },
> 
> Why did you remove the C99 style initialisers?

Because else things no longer fit on one line.
I prefered a clean structural overview over the protection against the
(almost nonexisting) risk of initializing the wrong member.

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
---584337861-213149330-1196151437=:10168--
