Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 0961BDDF23
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 17:09:30 +1000 (EST)
Date: Tue, 19 Jun 2007 09:09:18 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [patch 18/33] PS3: Frame buffer system-bus rework
In-Reply-To: <18039.31768.282185.497245@cargo.ozlabs.ibm.com>
Message-ID: <Pine.LNX.4.62.0706190908370.5713@pademelon.sonytel.be>
References: <20070615204749.629571012@am.sony.com>
	<46730D32.8060803@am.sony.com>
	<18039.31768.282185.497245@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-133955480-1182236958=:5713"
Cc: linuxppc-dev@ozlabs.org, linux-fbdev-devel@lists.sourceforge.net
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

---584337861-133955480-1182236958=:5713
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

	Hi Paul,

On Tue, 19 Jun 2007, Paul Mackerras wrote:
> Geoff Levand writes:
> > From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> > 
> > Convert the ps3fb device from a platform device to a PS3 system bus device.
> > Fix the remove and shutdown methods to support kexec and to make ps3fb a
> > loadable module.
> 
> Are you going to submit this to the fb maintainer (Antonio Daplas?) or
> do you want me to take it because of dependencies on other patches in
> your series?

I think it's best if you take it, since the changes to ps3fb depend on the
PS3 system bus device core changes.

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
---584337861-133955480-1182236958=:5713--
