Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 981B467CDC
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Nov 2006 21:15:36 +1100 (EST)
Date: Tue, 21 Nov 2006 11:15:32 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 7/16] powerpc: add support for ps3 platform
In-Reply-To: <200611211111.12882.arnd@arndb.de>
Message-ID: <Pine.LNX.4.62.0611211114220.21124@pademelon.sonytel.be>
References: <4554DACB.8060809@am.sony.com> <4559099A.6060805@am.sony.com>
	<17762.26999.152198.792581@cargo.ozlabs.ibm.com>
	<200611211111.12882.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1043387653-1164104132=:21124"
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>
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

---584337861-1043387653-1164104132=:21124
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Tue, 21 Nov 2006, Arnd Bergmann wrote:
> On Tuesday 21 November 2006 03:50, Paul Mackerras wrote:
> > The "ps3pf" name is pretty meaningless.  I think that, at the very
> > least, the directory name should be arch/powerpc/platforms/ps3.
> > Unless Arnd is prepared to argue strongly to the contrary, I will be
> > rejecting patches that create a platforms/ps3pf directory.
> 
> I don't care about the name at all, either way. However, I think it
> would be good to be consistant with the directory name and the name
> of identifiers in the code, so the function names should also be
> changed if the platform is name 'ps3'.

Indeed, and since we don't like changing all of these back and forth, it would
be nice to have a definitive decision soon.

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Sony Network and Software Technology Center Europe (NSCE)
Geert.Uytterhoeven@sonycom.com ------- The Corporate Village, Da Vincilaan 7-D1
Voice +32-2-7008453 Fax +32-2-7008622 ---------------- B-1935 Zaventem, Belgium
---584337861-1043387653-1164104132=:21124--
