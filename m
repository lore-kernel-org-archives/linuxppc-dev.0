Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Mon, 20 Aug 2007 17:43:08 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Stefan Assmann <sassmann@suse.de>
Subject: Re: PS3 improved video mode autodetection for HDMI/DVI
In-Reply-To: <46C9B172.9030309@suse.de>
Message-ID: <Pine.LNX.4.62.0708201740080.6197@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
	<46C405B3.2040401@suse.de>
	<Pine.LNX.4.62.0708201541230.6197@pademelon.sonytel.be>
	<46C9B172.9030309@suse.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1098284444-1187624588=:6197"
Cc: Linux/PPC Development <linuxppc-dev@ozlabs.org>,
	Cell Broadband Engine OSS Development <cbe-oss-dev@ozlabs.org>,
	Ben Collins <ben.collins@ubuntu.com>
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

---584337861-1098284444-1187624588=:6197
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 20 Aug 2007, Stefan Assmann wrote:
> >> btw, I get the following message while booting:
> >> PS3AV_CID_AV_VIDEO_DISABLE_SIG: failed 2 port 10
> >>
> >> does this ring a bell? I'm using kernel 2.6.22 with ps3 patches
> >>     
> >
> > Do you put your kernel in FLASH ROM (otheros.bld)?
> > Does it still happen after upgrading to a kernel that has
> > ps3-wip/ps3av-vesa-stripes-workaround.diff applied (e.g. Geoff's current git
> > tree)?
> >   
> Yes kernel is written to flash memory. I added
> ps3-wip/ps3av-vesa-stripes-workaround.diff to my source tree, the
> message persists, even using Geoff's git tree with my .config file and
> running oldconfig didn't change the behavior. I'll append my .config
> file. The message is the very first line printed at kernel boot.

I know you could get the PS3AV_CID_AV_VIDEO_DISABLE_SIG message in some cases
when booting immediately into a VESA mode.

I see you have

    CONFIG_CMDLINE="quiet sysrq=1 panic=42 video=ps3fb:mode:0"

Does it go away if you remove the `video=...'?

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
---584337861-1098284444-1187624588=:6197--
