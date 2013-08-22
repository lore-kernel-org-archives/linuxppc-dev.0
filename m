Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id DF8EE2C0091
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Aug 2013 06:06:06 +1000 (EST)
Date: Thu, 22 Aug 2013 21:05:58 +0100
From: Mark Brown <broonie@kernel.org>
To: Stephen Warren <swarren@wwwdotorg.org>
Message-ID: <20130822200558.GV26118@sirena.org.uk>
References: <cover.1377054540.git.b42378@freescale.com>
 <e9cf5e37f858dea78319720f007f66c8c063885f.1377054540.git.b42378@freescale.com>
 <52150763.8020707@wwwdotorg.org> <20130822114027.GA4258@MrMyself>
 <52166CF0.9080402@wwwdotorg.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature"; boundary="1MV0VfA6Y2yiVCnw"
In-Reply-To: <52166CF0.9080402@wwwdotorg.org>
Subject: Re: [PATCH v10 2/2] ASoC: fsl: Add S/PDIF machine driver
Cc: mark.rutland@arm.com, devicetree@vger.kernel.org,
 alsa-devel@alsa-project.org, lars@metafoo.de, festevam@gmail.com,
 s.hauer@pengutronix.de, Nicolin Chen <b42378@freescale.com>, timur@tabi.org,
 rob.herring@calxeda.com, tomasz.figa@gmail.com, p.zabel@pengutronix.de,
 R65777@freescale.com, shawn.guo@linaro.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--1MV0VfA6Y2yiVCnw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Aug 22, 2013 at 01:56:32PM -0600, Stephen Warren wrote:
> On 08/22/2013 05:40 AM, Nicolin Chen wrote:

> > Documentation/devicetree/bindings/sound/spdif-receiver.txt
> > If I understand correctly, this doc for the dummy codec should be invalid?

> Yes, I'm not convinced that binding is a good idea; it describes
> something that often doesn't actually exist in HW. (Sometimes there's a
> real S/PDIF receiving device on board, but sometimes there's nothing
> except a jack/connector).

> It'd be useful if other DT binding maintainers could weigh in on this to
> confirm/deny my thoughts.

I think the binding should be changed to replace the word "dummy" with
"generic" and perhaps some verbiage about not requiring software
configuration.  I think given the unidirectional nature of S/PDIF it's
reasonable to represent a jack like this - the hardware can't generally
tell if there's anything at the other end of the link anyway, for all
pratical purposes the transmit end just has to blindly send.

--1MV0VfA6Y2yiVCnw
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQIcBAEBAgAGBQJSFm8iAAoJELSic+t+oim9XT8P/jmtdNchB0XJLs8+fq1fdxS1
I1YqGnJD4wnRuDGeIkfwz8YR0bd1a+aoiHZTp9CUDWG8tw7awihtZNo74socvriy
MY9RImLETAGmrsyghYuziU1oV3qvc3hDoH9J66LRRgMEEJIS36KVReyZJ0wh9vpr
TM8K6WaPkxa8Dr0MxYjrMi0hLTm6TiPPfPZs68H3eIl9wrHcpAFWY96T2OX84XOM
IbqY6cCEsjNCRbMhEhtj1r6Di5h7AfPsuOf8rXPYVX1nYinpj1ybIY6q1YGgP8xl
MlaSPUyW6p3jQtgmt/v/Wt5qZOUOVhl/5sp4t65KuoCKnlQ3PB0sC+tBLcmM8URH
hZ+PDFBKdWumuF7cPrULBBzBsIfCHiTQ2kFCwW4e+Nxg3s1YqYBcwpDA18u7xPLC
3CLDPsMvAgXQjG0n6/PRAvlaR0bIaoueWi+kKQYu2od6ix+iTYz3UquOTfx801h4
sabUZDiF3lRQaLhsJNAlzugIcxK8B7UC5uOFRDI0/r26o6MWP4uoGb7Cbx1RDuuP
wHSLkoW1wmftH+vqXOYPRa9lVFd891VT/Rgdj6DNX3jVp+1lhF/EZ4Iph6xJZlHa
hqOFDHfvSI+6plyypppJR1tc1yrHZ14echmmEsUDdXDY//HlvFsBjNvjZISlMMoR
fDNNnuFqdskrYYDtloc6
=HclX
-----END PGP SIGNATURE-----

--1MV0VfA6Y2yiVCnw--
