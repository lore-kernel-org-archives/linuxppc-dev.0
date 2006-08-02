Return-Path: <jose.franca.ext@siemens.com>
Received: from relay1.siemens.pt (relay-pt1.siemens.pt [194.145.62.201])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB55267BB0
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Aug 2006 02:45:54 +1000 (EST)
Received: from fw-mta1.siemens.pt (fw-mta-pt1.siemens.pt [141.29.156.201])
	by relay1.siemens.pt (8.13.1/8.13.1) with ESMTP id k72GjcDd021399
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 17:45:38 +0100
Received: from PTLISI052MSX.PT001.SIEMENS.NET (ptlisi052n01.pt001.siemens.net
	[141.29.156.67])
	by fw-mta1.siemens.pt (Hvm) with ESMTP id k72GjnB29959
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Aug 2006 17:45:49 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Sloooooowwww CFI Flash programming
Date: Wed, 2 Aug 2006 17:45:48 +0100
Message-ID: <4051B1A83682514BA8529BCADDA45F086EE65A@PTLISI050MSX.PT001.SIEMENS.NET>
From: "Franca, Jose Filipe \(ext\)" <jose.franca.ext@siemens.com>
To: <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

That is implemented in the 2.6 kernels. Are you sugesting a merge with
2.6 code? Or there is a patch that implements that in 2.4 kernels?

-----Original Message-----
From: Frank [mailto:frannk_m1@yahoo.com]=20
Sent: quarta-feira, 2 de Agosto de 2006 17:41
To: Franca, Jose Filipe (ext); linuxppc-dev@ozlabs.org
Subject: Re: Sloooooowwww CFI Flash programming



--- "Franca, Jose Filipe (ext)" <jose.franca.ext@siemens.com>
wrote:

> Hello all!
>=20
> 	I'm using a linux-2.4.31 based kernel in our board and we are
> using a AM29LV040B flash device. Our problem is that flash
> programming is a rather slow process. The responsible is the
> file cfi_cmdset_0002.c. Is there any patch that fixes this
> problem and enables fast programming mode?
>=20
>

You probably need buffer writes enabled.

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20
