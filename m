Return-Path: <bounces@nabble.com>
Received: from talk.nabble.com (www.nabble.com [72.21.53.35])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1DBB3DDF6D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 27 Apr 2007 05:51:35 +1000 (EST)
Received: from [72.21.53.38] (helo=jubjub.nabble.com)
	by talk.nabble.com with esmtp (Exim 4.50) id 1HhA03-0006ks-1D
	for linuxppc-embedded@ozlabs.org; Thu, 26 Apr 2007 12:51:31 -0700
Message-ID: <10207511.post@talk.nabble.com>
Date: Thu, 26 Apr 2007 12:51:30 -0700 (PDT)
From: rvk <rvkisley@yahoo.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: ML403 and PPC4xx_DMA ?
In-Reply-To: <1177603586.5532.20.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
References: <1177603586.5532.20.camel@localhost>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


The core itself for 405 will not have DCR: Device control registers - becau=
se
no device control bus. Have to look at board spec for whether there is a
replacement and what that is. Based on other comments you are on uncertain
ground, likely defining a few things yourself. Interesting that the base
header has a dep for DCRN based on that config.  I assume you have UG011 do=
c
from the Xilinx website.=20

Joachim F=C3=B6rster wrote:
>=20
> Hi all,
>=20
> PS: I tried to compile a kernel image with CONFIG_PPC4xx_DMA enabled,
> but gcc complains about missing definitions in ppc4xx_dma.c ... e.g.
> DCRN_DMASR (defined in ibm405.h). Well I guess I have to have
> DCRN_MASR_BASE defined in xparameters_ml403.h .... but defined to what?
>=20
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
>=20

--=20
View this message in context: http://www.nabble.com/ML403-and-PPC4xx_DMA---=
tf3652591.html#a10207511
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
