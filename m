Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id 47531DDDDB
	for <linuxppc-dev@ozlabs.org>; Sat,  8 Dec 2007 08:30:59 +1100 (EST)
Date: Fri, 7 Dec 2007 22:30:53 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Balbir Singh <balbir@linux.vnet.ibm.com>
Subject: Re: [PATCH] Fake NUMA emulation for PowerPC
In-Reply-To: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
Message-ID: <Pine.LNX.4.62.0712072229280.26862@pademelon.sonytel.be>
References: <20071207211425.10223.91240.sendpatchset@balbir-laptop>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1040896501-1197063053=:26862"
Cc: linuxppc-dev@ozlabs.org, LKML <linux-kernel@vger.kernel.org>
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

---584337861-1040896501-1197063053=:26862
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Sat, 8 Dec 2007, Balbir Singh wrote:
> +	if (strstr(p, "fake="))
> +		cmdline = p + 5;	/* 5 is faster than strlen("fake=") */

Really? My gcc is smart enough to replace the `strlen("fake=")' by 5, even
without -O.

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
---584337861-1040896501-1197063053=:26862--
