Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay005.isp.belgacom.be (mailrelay005.isp.belgacom.be
	[195.238.6.171]) by ozlabs.org (Postfix) with ESMTP id 1196ADDEE4
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Mar 2008 00:40:03 +1100 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: Trouble with SCC UART ports when moving from ppc to powerpc
Date: Thu, 20 Mar 2008 14:39:56 +0100
References: <200803071521.00383.laurentp@cse-semaphore.com>
	<200803101317.04455.laurentp@cse-semaphore.com>
	<20080317153326.GA2644@loki.buserror.net>
In-Reply-To: <20080317153326.GA2644@loki.buserror.net>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1812929.7Oss4XKXOI";
	protocol="application/pgp-signature"; micalg=pgp-sha1
Message-Id: <200803201439.59806.laurentp@cse-semaphore.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

--nextPart1812929.7Oss4XKXOI
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hi Scott,

On Monday 17 March 2008 16:33, Scott Wood wrote:
> On Mon, Mar 10, 2008 at 01:17:01PM +0100, Laurent Pinchart wrote:
> > On Friday 07 March 2008 17:21, Scott Wood wrote:
> > > cpm2_reset() doesn't currently actually reset the CPM, for some reason
> > > (unlike cpm1).  This should probably be fixed, though then we'd have =
to
> > > deal with assigning SMC parameter RAM addresses ourselves.
> >
> > I had overlooked that. Resetting the CPM in cpm2_reset() helps. Is there
> > any reason not to rset the CPM in cpm2_reset() ?
>
> The only issue I'm aware of other than the SMC parameter RAM relocation is
> that the reset can't happen if the early udbg printk is being used.
>
> > How should SMC parameter RAM assignment be handled ? I'm not very
> > familiar with the CPM1,
>
> CPM1 has hardcoded SMC parameter RAM addresses, so it's not relevant here.
>
> > but for CPM2 the cpm_uart driver could easily cpm_dpalloc() parameter
> > RAM.
>
> It can, yes.  Patches welcome. :-)

I'm working on a patch. I'm not sure how to handle the early udbg printk=20
problem, so the first version will just ignore it.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75

--nextPart1812929.7Oss4XKXOI
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.5 (GNU/Linux)

iD4DBQBH4mkv8y9gWxC9vpcRAlvWAJic+L3yXgHbHSQdZ5v0hmw0BExRAKC92DZZ
1Jk+p359vgm15DsQsWkzbA==
=8dg8
-----END PGP SIGNATURE-----

--nextPart1812929.7Oss4XKXOI--
