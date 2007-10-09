Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 75F52DE032
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 19:35:57 +1000 (EST)
Date: Tue, 9 Oct 2007 11:35:52 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Ranulf Doswell <ralf@ranulf.net>
Subject: Re: [patch 6/6] PS3: Add os-area database routines
In-Reply-To: <18a15270710081559m3236126r85f797718300756f@mail.gmail.com>
Message-ID: <Pine.LNX.4.62.0710091135240.6961@pademelon.sonytel.be>
References: <20071006213542.311447584@am.sony.com>
	<20071006213542.954029915@am.sony.com>
	<18a15270710080648x3b5f1135meea3d7b048a1a543@mail.gmail.com>
	<470A6E4E.5090009@am.sony.com>
	<18a15270710081559m3236126r85f797718300756f@mail.gmail.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-613365021-1191922552=:6961"
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

---584337861-613365021-1191922552=:6961
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 8 Oct 2007, Ranulf Doswell wrote:
> On 08/10/2007, Geoff Levand <geoffrey.levand@am.sony.com> wrote:
> > > How do we go about claiming one of these OS_AREA_DB_OWNER_ keys? I'd
> > > very much like to use this functionality in my python-ps3 games library.
> >
> > It sounds like you should be storing your info in the file system like
> > all other applications do.
> 
> 
> I'd agree that for large amounts of application specific data, the
> filesystem is the correct approach.
> 
> However, in this case the only data required is a single identifier used to
> identify one PS3 from another, and in fact this single 64-bit token can be
> shared amongst many other applications that require the same function -
> certainly I intend to expose it in a common way in my games library's API
> for all users of the library.

MAC address?

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
---584337861-613365021-1191922552=:6961--
