Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 6C9F0DDFEB
	for <linuxppc-dev@ozlabs.org>; Sat, 16 Jun 2007 00:43:08 +1000 (EST)
Date: Fri, 15 Jun 2007 16:43:05 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: David Woodhouse <dwmw2@infradead.org>
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
In-Reply-To: <1181918159.25228.543.camel@pmac.infradead.org>
Message-ID: <Pine.LNX.4.62.0706151642010.8248@pademelon.sonytel.be>
References: <20070615113919.142332000@pademelon.sonytel.be>
	<20070615120848.352093000@pademelon.sonytel.be>
	<1181918159.25228.543.camel@pmac.infradead.org>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1219061913-1181918585=:8248"
Cc: Jens Axboe <axboe@kernel.dk>,
	"James E.J. Bottomley" <James.Bottomley@SteelEye.com>,
	linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
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

---584337861-1219061913-1181918585=:8248
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 15 Jun 2007, David Woodhouse wrote:
> On Fri, 2007-06-15 at 13:39 +0200, Geert Uytterhoeven wrote:
> > Add a Disk Storage Driver for the PS3:
> >   - Implemented as a block device driver with a dynamic major
> >   - Disk names (and partitions) are of the format ps3d%c(%u)
> >   - Uses software scatter-gather with a 64 KiB bounce buffer as the hypervisor
> >     doesn't support scatter-gather
> 
> Any particular reason why this is done as a separate block device driver
> rather than as SCSI?

Because no new fake SCSI drivers are accepted anymore.

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
---584337861-1219061913-1181918585=:8248--
