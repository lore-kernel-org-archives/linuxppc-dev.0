Return-Path: <Horst.KRONSTORFER@frequentis.com>
Received: from webmail.frequentis.com (webmail.frequentis.com [213.47.210.151])
	by ozlabs.org (Postfix) with ESMTP id BF90767A63
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Apr 2006 03:23:37 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [QUESTION] MPC834x DMA Support 
Date: Thu, 27 Apr 2006 19:23:29 +0200
Message-ID: <C5BA91F04186584EB68FD42BB4993E6BC1B63C@FRQWOLEX01.frequentis.frq>
From: "KRONSTORFER Horst" <Horst.KRONSTORFER@frequentis.com>
To: <wd@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> -----Original Message-----
> From: wd@denx.de [mailto:wd@denx.de]=20
> Sent: Donnerstag, 27. April 2006 18:28
> To: KRONSTORFER Horst
> Cc: linuxppc-dev@ozlabs.org
> Subject: Re: [QUESTION] MPC834x DMA Support=20
>=20
> In message=20
> <C5BA91F04186584EB68FD42BB4993E6BC1B5C6@FRQWOLEX01.frequentis.
> frq> you wrote:
> >=20
> > does anyone know if the mpc834x's dma unit supports dma=20
> operation only=20
> > between pci and csb or also between csb and csb, f.e. devices=20
> > connected via the lbc (f.e. ram and a dsp)?
>=20
> This should work. We used this  to  initialize  ECC  memory. =20
> But  be careful  about your performance expectations - ask=20
> Freescale what you can get out of memory to memory DMA.=20
> [Sorry, I'm  still  waiting  for replies from FSL myself.]
>

thanks for the hints!

-h
=20
> Best regards,
>=20
> Wolfgang Denk
>=20
> --
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email:=20
> wd@denx.de You speak of courage. Obviously you do not know=20
> the  difference  bet- ween  courage and foolhardiness. Always=20
> it is the brave ones who die, the soldiers.
> 	-- Kor, the Klingon Commander, "Errand of Mercy",
> 	   stardate 3201.7
>=20
