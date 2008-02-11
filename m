Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 82DC1DDDFF
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Feb 2008 21:36:42 +1100 (EST)
Date: Mon, 11 Feb 2008 11:36:39 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Simon Holm =?ISO-8859-1?Q?Th=F8gersen?= <odie@cs.aau.dk>
Subject: Re: [PATCH] Fix compilation of powerpc asm-offsets.c with old gcc
In-Reply-To: <1202495464.6722.13.camel@odie.local>
Message-ID: <Pine.LNX.4.64.0802111134310.8544@vixen.sonytel.be>
References: <18347.34100.60973.215093@cargo.ozlabs.ibm.com>
	<alpine.LFD.1.00.0802071449240.2896@woody.linux-foundation.org>
	<20080208120623.3ad74e3a.pj@sgi.com>
	<1202495464.6722.13.camel@odie.local>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584349381-491899868-1202726199=:8544"
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Paul Jackson <pj@sgi.com>, paulus@samba.org, akpm@linux-foundation.org,
	Linus Torvalds <torvalds@linux-foundation.org>, tglx@linutronix.de
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

---584349381-491899868-1202726199=:8544
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 8 Feb 2008, Simon Holm Th鴊ersen wrote:
> fre, 08 02 2008 kl. 12:06 -0600, skrev Paul Jackson:
> > Linus wrote:
> > > Please, when mentioning hex numbers, also do the one-liner shortlog.
> > > ...
> > > without _requiring_ people to be git users to get the gist of the 
> > > matter, ok?
> > 
> > 
> > Thanks for sticking up for us git-challenged contributors.
> > 
> > Can anyone point me at instructions providing the shortest
> > path for getting from one of those git hex numbers to the
> > log or change it represents, for non-git users?
> 
> Use gitweb [1], Linus' tree is here [2]. Just search for the hex.
> 
> [1] http://git.kernel.org/
> [2]
> http://git.kernel.org/?p=linux/kernel/git/torvalds/linux-2.6.git;a=summary

As the IDs are supposed to be unique, it doesn't matter where you look it up,
as long as the tree has that commit ;-)

BTW, time for Google to start handling git IDs?

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Network and Software Technology Center Europe
The Corporate Village 路 Da Vincilaan 7-D1 路 B-1935 Zaventem 路 Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Network and Software Technology Center Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 路 B-1840 Londerzeel 路 Belgium
VAT BE 0413.825.160 路 RPR Brussels
Fortis Bank Zaventem 路 Swift GEBABEBB08A 路 IBAN BE39001382358619
---584349381-491899868-1202726199=:8544--
