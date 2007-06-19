Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (unknown [80.88.33.193])
	by ozlabs.org (Postfix) with ESMTP id 2BA8ADDF10
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 17:06:51 +1000 (EST)
Date: Tue, 19 Jun 2007 09:06:43 +0200 (CEST)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: David Miller <davem@davemloft.net>
Subject: Re: [patch 4/6] ps3: Disk Storage Driver
In-Reply-To: <20070618.230357.08341020.davem@davemloft.net>
Message-ID: <Pine.LNX.4.62.0706190905560.5713@pademelon.sonytel.be>
References: <20070615171545.316dfac7@the-village.bc.nu>
	<20070615.141917.85409547.davem@davemloft.net>
	<20070619055358.GD18542@lst.de>
	<20070618.230357.08341020.davem@davemloft.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-584337861-78175883-1182236803=:5713"
Cc: axboe@kernel.dk, James.Bottomley@SteelEye.com, linux-scsi@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	paulus@samba.org, dwmw2@infradead.org, hch@lst.de, alan@lxorguk.ukuu.org.uk
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

---584337861-78175883-1182236803=:5713
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Mon, 18 Jun 2007, David Miller wrote:
> What I really care about is what will work transparently for existing
> userspace.  In particular, distribution installers and existing tools
> like fdisk.
> 
> When a slice it being exported, it's not being exported like that so
> that the client can just spam a disk label into it, it's for exporting
> one slice.  So we might want (using the scsi naming as an arbitrary
> example case) /dev/sda1 to be created but not /dev/sda
> 
> How exactly do you envision this kind of thing working?

How do distribution installers handle USB disks and memory cards? Some tend
to be partitioned, some don't.

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
---584337861-78175883-1182236803=:5713--
