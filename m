Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Fri, 25 Jan 2008 14:12:44 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH 3/3] Cell IOMMU static mapping support
In-Reply-To: <9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
Message-ID: <Pine.LNX.4.64.0801251409500.15977@vixen.sonytel.be>
References: <edf2d9650b044e2bc21e9b74ad1044f4e5b6615c.1201257905.git.michael@ellerman.id.au>
	<9ce4678eef9e50908969eb1ef8470e307f3076ff.1201257905.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1818273090-1201266764=:15977"
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
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

---584349381-1818273090-1201266764=:15977
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 25 Jan 2008, Michael Ellerman wrote:
> Citing "release early release often", I'm posting this now as a mega-patch
> to get people looking at it. I'll try to split it up and make it look a
> little prettier before submitting it.
> 
> The intent of this patch is to setup (on certain machines) a "static" IOMMU
> mapping of all of memory, to reduce the overhead of the IOMMU. If anyone has
> a better name than "static" I'm all ears.

Early mapping?
Premapping?

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
---584349381-1818273090-1201266764=:15977--
