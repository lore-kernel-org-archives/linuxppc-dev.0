Return-Path: <mcr@sandelman.ottawa.on.ca>
Received: from pike.sandelman.ca (pike.sandelman.ca [205.150.200.164])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "pike.sandelman.ca",
	Issuer "Michael Richardson" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 8A90167DC7
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Jul 2005 02:33:39 +1000 (EST)
To: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: Message from Kumar Gala <kumar.gala@freescale.com> of "Wed,
	27 Jul 2005 18:34:23 CDT."
	<3965D4DD-1628-4463-890F-106DB5BC6931@freescale.com>
References: <20050727101502.B1114@cox.net>
	<3965D4DD-1628-4463-890F-106DB5BC6931@freescale.com>
Date: Fri, 29 Jul 2005 12:33:33 -0400
Message-ID: <5027.1122654813@marajade.sandelman.ottawa.on.ca>
From: Michael Richardson <mcr@sandelman.ottawa.on.ca>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	kyle@mcmartin.ca, "Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH 00/14] ppc32: Remove board ports that are no longer
	maintained
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


>>>>> "Kumar" == Kumar Gala <kumar.gala@freescale.com> writes:
    >> When we recover our history from the linuxppc-2.4/2.5 trees we
    >> can show exactly how long it's been since anybody touched ep405.
    >> 
    >> Quick googling shows that it's been almost 2 years since the last
    >> mention of ep405 (exluding removal discussions) on
    >> linuxppc-embedded.  Last ep405-related commits are more than 2
    >> years ago.

  So, I'll bet I can find other parts of the kernel tree that haven't
been touched in 2 years.  Maybe there isn't anything to fix?

  Happens that in our case,
	  a) the board is the basis to our own board.
	  b) we only moved to 2.6 in May.

  So, I just don't get removing board support files.

- -- 
] Michael Richardson          Xelerance Corporation, Ottawa, ON |  firewalls  [
] mcr @ xelerance.com           Now doing IPsec training, see   |net architect[
] http://www.sandelman.ca/mcr/    www.xelerance.com/training/   |device driver[
]                    I'm a dad: http://www.sandelman.ca/lrmr/                 [
  
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.2 (GNU/Linux)
Comment: Finger me for keys

iQCVAwUBQupaXIqHRg3pndX9AQFnGQP+JXX0ZTKW35LljC/ighUPpmcdClRlmWP2
fsnofXYNi2v9QEkYpoS8pHMc3ClKHT8MFzK/nsDe1CFWPxxavK+365usf77DSGWB
bjZ8CZWjkvDt7IMjBxEnSlzCTVt39Gtjq1zM/DMY0SOi1ccB7TIZE+1Ol3zkYnW5
2X6+0SKgS6Q=
=kcQj
-----END PGP SIGNATURE-----
