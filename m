Return-Path: <Clive.Jenkins@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 46DC8689AE
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  2 Feb 2006 20:38:09 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Yosemite/440EP why are readl()/ioread32() setup to
	readlittle-endian?
Date: Thu, 2 Feb 2006 09:35:56 -0000
Message-ID: <35786B99AB3FDC45A8215724617919736D921C@gbrwgceumf01.eu.xerox.net>
From: "Jenkins, Clive" <Clive.Jenkins@xerox.com>
To: "Eugene Surovegin" <ebs@ebshome.net>, "Peter Korsgaard" <jacmet@sunsite.dk>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

A driver for some device that could be connected to (or plugged into)
a variety of different platforms of different architecture.
A driver for a core that could be implemented within an FPGA on
multiple platforms.

Clive

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net]=20
Sent: 02 February 2006 09:08
To: Peter Korsgaard
Cc: Kumar Gala; linuxppc-embedded@ozlabs.org; Jenkins, Clive
Subject: Re: Yosemite/440EP why are readl()/ioread32() setup to
readlittle-endian?


On Thu, Feb 02, 2006 at 09:09:17AM +0100, Peter Korsgaard wrote:
> On 2/2/06, Kumar Gala <galak@kernel.crashing.org> wrote:
> > > What is the preferred way of accessing non-PCI devices then?
Direct
> > > pointer access?
> >
> > No direct pointer access is bad. On PPC You can use
> > in_be{8,16,32}/out_be{8,16,32}
>=20
> What about arch independent drivers? Are there any generic approach
> for this or do you have to stick to ugly #ifdefs to decide between
> in_be32/inl ?

I'm curious, could you give an example of such arch independent=20
driver?

--=20
Eugene
