Return-Path: <Geert.Uytterhoeven@sonycom.com>
Received: from vervifontaine.sonycom.com (vervifontaine.sonytel.be
	[80.88.33.193]) by ozlabs.org (Postfix) with ESMTP id D4E84DDDF0
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 01:30:30 +1100 (EST)
Date: Fri, 30 Nov 2007 15:30:28 +0100 (CET)
From: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Sender: geert@sonytel.be
To: Olof Johansson <olof@lixom.net>
Subject: Re: [PATCH 1/11] ibm_newemac: Add BCM5248 and Marvell 88E1111 PHY
	support
In-Reply-To: <20071130142736.GB3117@lixom.net>
Message-ID: <Pine.LNX.4.62.0711301530190.27308@pademelon.sonytel.be>
References: <1196401223.5661.297518056501.qpush@grosgo>
	<20071130054126.39BDCDDE0A@ozlabs.org>
	<20071130142736.GB3117@lixom.net>
MIME-Version: 1.0
Content-Type: MULTIPART/MIXED;
	BOUNDARY="-584337861-1956073448-1196433028=:27308"
Cc: linuxppc-dev@ozlabs.org, jgarzik@pobox.com, netdev@vger.kernel.org
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

---584337861-1956073448-1196433028=:27308
Content-Type: TEXT/PLAIN; charset=UTF-8
Content-Transfer-Encoding: 8BIT

On Fri, 30 Nov 2007, Olof Johansson wrote:
> On Fri, Nov 30, 2007 at 04:40:23PM +1100, Benjamin Herrenschmidt wrote:
> 
> > +static int m88e1111_init(struct mii_phy *phy)
> > +{
> > +	printk("%s: Marvell 88E1111 Ethernet\n", __FUNCTION__);
> 
> KERN_ level?

pr_

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
---584337861-1956073448-1196433028=:27308--
