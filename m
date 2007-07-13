Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Fri, 13 Jul 2007 15:16:28 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] PS3 improved video mode autodetection for HDMI/DVI
In-Reply-To: <1184330152.6059.221.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.62.0707131516070.18802@pademelon.sonytel.be>
References: <Pine.LNX.4.62.0707121029320.12797@pademelon.sonytel.be>
	<20070712140620.GB507@ping.uio.no>
	<Pine.LNX.4.62.0707121704270.8368@pademelon.sonytel.be>
	<20070713094814.GD507@ping.uio.no>
	<Pine.LNX.4.62.0707131404320.18802@pademelon.sonytel.be>
	<1184330152.6059.221.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1402992852-1184332588=:18802"
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

---584337861-1402992852-1184332588=:18802
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 13 Jul 2007, Benjamin Herrenschmidt wrote:
> > Since 720p is a broadcast mode, I can't make it default to fullscreen, as a
> > part of the image will fall off on most monitors.
> 
> Do you have any info from the EDID block that would tell you whether the
> monitor displays the full picture (typical of flat panels) or not ?

No, all I have is struct ps3av_info_monitor.

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
---584337861-1402992852-1184332588=:18802--
