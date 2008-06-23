Return-Path: <Geert.Uytterhoeven@sonycom.com>
Date: Mon, 23 Jun 2008 14:07:50 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Gunnar von Boehn <VONBOEHN@de.ibm.com>
Subject: Re: [RFC 1/3] powerpc: __copy_tofrom_user tweaked for Cell
In-Reply-To: <OFD65B3B6C.9A2E5A1E-ONC1257471.002B578F-C1257471.002ECE46@de.ibm.com>
Message-ID: <Pine.LNX.4.64.0806231406130.8773@vixen.sonytel.be>
References: <OF2260963C.4B69232D-ONC125746E.0032489D-C125746E.003FD09E@de.ibm.com>
	<247666.12345.qm@web33104.mail.mud.yahoo.com>
	<OFD65B3B6C.9A2E5A1E-ONC1257471.002B578F-C1257471.002ECE46@de.ibm.com>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584349381-1646437380-1214222870=:8773"
Cc: Mark Nelson <markn@au1.ibm.com>, sanjay3000@yahoo.com,
	Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@ozlabs.org,
	Michael Ellerman <ellerman@au1.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---584349381-1646437380-1214222870=:8773
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 23 Jun 2008, Gunnar von Boehn wrote:
> > The problem is that the dcbz will generate the alignment exception
> > regardless of whether the data is actually unaligned or not.
> > Once you're on that code path, performance can't be good, can it?
> 
> In which case will DCBZ create an aligned exception?

When using dcbz on uncached memory, IIRC.

With kind regards,

Geert Uytterhoeven
Software Architect

Sony Techsoft Centre
The Corporate Village · Da Vincilaan 7-D1 · B-1935 Zaventem · Belgium

Phone:    +32 (0)2 700 8453
Fax:      +32 (0)2 700 8622
E-mail:   Geert.Uytterhoeven@sonycom.com
Internet: http://www.sony-europe.com/

Sony Technology and Software Centre Europe
A division of Sony Service Centre (Europe) N.V.
Registered office: Technologielaan 7 · B-1840 Londerzeel · Belgium
VAT BE 0413.825.160 · RPR Brussels
Fortis 293-0376800-10 GEBA-BE-BB
---584349381-1646437380-1214222870=:8773--
