Return-Path: <mcr@marajade.sandelman.ca>
Received: from lists.sandelman.ca (cod.sandelman.ca [192.139.46.139])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "lists.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 99FB86861E
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 31 Oct 2005 16:12:42 +1100 (EST)
To: Alex Zeffertt <ajz@cambridgebroadband.com>
In-Reply-To: Message from Alex Zeffertt <ajz@cambridgebroadband.com> of "Wed,
	26 Oct 2005 09:59:35 BST."
	<20051026095935.66fe98d8.ajz@cambridgebroadband.com>
References: <F795765B112E7344AF36AA91127964158496CE@xmb-sjc-212.amer.cisco.com>
	<20051026095935.66fe98d8.ajz@cambridgebroadband.com>
Date: Fri, 28 Oct 2005 10:42:54 -0400
Message-ID: <6976.1130510574@marajade.sandelman.ca>
From: mcr <mcr@marajade.sandelman.ca>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: compact flash driver 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

-----BEGIN PGP SIGNED MESSAGE-----


>>>>> "Alex" == Alex Zeffertt <ajz@cambridgebroadband.com> writes:
    >> Hello All, Are there any compact flash driver supported for Linux
    >> 2.6? If there is where can i get the source code.  Thanks, Bizhan
    >> 

    Alex> I think that CF cards just get treated the same as any other
    Alex> IDE disk by linux.  No special driver needed.

  Yes. There are some gotchas with newer pcmcia/cardbus flash cards.
For instance, Silicon Systems devices claim to support IORDY, but don't,
which results in a system hang.  I imagine that the same kind of things
will show up in newer CF devices, although I think that CF can't support
DMA.
  It also depends upon how you interface CF: via an IDE controller, or
via a cardbus interface.

  I expect to have a git tree with stuff available soon.

- -- 
]       ON HUMILITY: to err is human. To moo, bovine.           |  firewalls  [
]   Michael Richardson,    Xelerance Corporation, Ottawa, ON    |net architect[
] mcr@xelerance.com      http://www.sandelman.ottawa.on.ca/mcr/ |device driver[
] panic("Just another Debian GNU/Linux using, kernel hacking, security guy"); [
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQ2I47IqHRg3pndX9AQHzEwQAu53kgQ2F+gIUBilfigelHgFlh4dSJ/uu
X/QemYuRvya8ozuoGSEbh4aY4RleSWikw0AAv5rz8HVwm/3JjnE1k0C8vU2/kHyY
2PYvY/X2SJI4w6HNokFbAjM0IlV56zApZZTR0hGBbvCrqC4md2xxuY3SoJZZwHtY
36hwZtdVSKg=
=ib5u
-----END PGP SIGNATURE-----
