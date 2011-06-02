Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
	by ozlabs.org (Postfix) with SMTP id 008B8B6FC0
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jun 2011 01:17:09 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
	by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new,
	port 10024) with SMTP
	id 04389-03 for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  2 Jun 2011 16:16:57 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 1/2] ppc/85xx: create a platform node for PCI EDAC device
Date: Thu, 2 Jun 2011 16:15:38 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6D8AD6B@saturn3.aculab.com>
In-Reply-To: <20110602151413.GA6590@oksana.dev.rtsoft.ru>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Anton Vorontsov" <avorontsov@mvista.com>,
	"Dmitry Eremin-Solenikov" <dbaryshkov@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

=20
> > +int __init fsl_add_pci_err(void)
>=20
> static :-)

and why __ ?
aren't such names reserved in the C language for some purpose.

	David
