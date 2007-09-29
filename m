Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Sat, 29 Sep 2007 10:00:13 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [Cbe-oss-dev] [patch 0/8] PS3 AV Settings Driver patches for
	2.6.24
In-Reply-To: <46FD5604.3060104@am.sony.com>
Message-ID: <Pine.LNX.4.62.0709290957580.21636@pademelon.sonytel.be>
References: <20070926163308.772580000@pademelon.sonytel.be>
	<1190860285.6502.6.camel@concordia> <46FBE6FD.3030605@am.sony.com>
	<1190968833.15970.3.camel@concordia> <46FD5604.3060104@am.sony.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1157957658-1191052813=:21636"
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net,
	cbe-oss-dev@ozlabs.org, "Antonino A. Daplas" <adaplas@gmail.com>
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

---584337861-1157957658-1191052813=:21636
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 28 Sep 2007, Geoff Levand wrote:
> Michael Ellerman wrote:
> > On Thu, 2007-09-27 at 10:23 -0700, Geoff Levand wrote:
> >> Michael Ellerman wrote:
> >> > On Wed, 2007-09-26 at 18:33 +0200, Geert Uytterhoeven wrote:
> >> >> Question: As several DVI-D displays advertise they support 1080i modes while
> >> >> they actually don't (cfr. the quirk database), perhaps I should drop 1080i
> >> >> modes completely from the ps3av_preferred_modes[] table? Usually 720p looks
> >> >> better than 1080i anyway.  What do you think?
> >> > 
> >> > Definitely. If the autodetection fails Linux is basically unusable on
> >> > PS3 unless you hack the kernel sources and build your own kboot and
> >> > otheros.bld - not entirely trivial for novice users. So it's pretty
> >> > important that it works 100%.
> >> 
> >> It is not that bad.  If a bootloader is configued to use autodetection
> >> so that it is shown at best video mode, then it should have advertised
> >> key sequences to default to known video modes, with at least a 480p 'safe'
> >> mode.
> > 
> > Oh OK, that is a good idea. What's the "safe mode" key sequence for the
> > otheros.bld you provide on kernel.org?
> 
> I don't maintain that, and have no idea how it sets its video mode.  Did you
> have trouble with it?  I know in the past it used a fixed 480p mode. 

It uses the autodetect mode. In the past, the kernel defaulted to 480p for
DVI-D/HDMI displays, 480i for other displays.

So far no one complained about the new otheros.bld (AFAIK). Which doesn't mean
that (a) the problem doesn't happen and (b) it wouldn't be nice to have a `safe
mode' key sequence...

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
---584337861-1157957658-1191052813=:21636--
