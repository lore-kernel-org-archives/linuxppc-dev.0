Return-Path: <Martin.Leisner@xerox.com>
Received: from wvmler2.mail.xerox.com (wvmler2.mail.xerox.com [13.8.138.217])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "wvmler2.mail.xerox.com",
	Issuer "wvmler2.mail.xerox.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 94781DDE02
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 24 May 2007 04:54:04 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Subject: RE: anyone have a good config file for a taiga/hpc2 with a 7448?
Date: Wed, 23 May 2007 14:43:08 -0400
Message-ID: <556445368AFA1C438794ABDA8901891C034458E3@usa0300ms03.na.xerox.net>
In-Reply-To: <8386E52C-335E-46E9-9608-8FEAC3A57BC9@kernel.crashing.org>
References: <556445368AFA1C438794ABDA8901891C034458D9@usa0300ms03.na.xerox.net>
	<8386E52C-335E-46E9-9608-8FEAC3A57BC9@kernel.crashing.org>
From: "Leisner, Martin" <Martin.Leisner@xerox.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: "Lund, Nathan" <Nathan.Lund@xerox.com>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

ah, yes, but the tundra ethernet support only started to appear in the=20
2.6.20 tree!!

We have a 2.6.10 where the ethernet worked and 2.6.19 with
non-functional
ethernet and I was wondering why...

thanks much,

marty

> -----Original Message-----
> From:=20
> linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozlabs.org=20
> [mailto:linuxppc-embedded-bounces+martin.leisner=3Dxerox.com@ozl
> abs.org] On Behalf Of Kumar Gala
> Sent: Wednesday, May 23, 2007 8:06 AM
> To: Leisner, Martin
> Cc: linuxppc-embedded@ozlabs.org
> Subject: Re: anyone have a good config file for a taiga/hpc2=20
> with a 7448?
>=20
>=20
> On May 22, 2007, at 1:41 PM, Leisner, Martin wrote:
>=20
> > Before I tried to do one myself, I figured I'd bounce it=20
> off to see if
> > anyone has a working
> > .config (the newer kernel, the better).
>=20
> Does arch/powerpc/configs/mpc7448_hpc2_defconfig not work for you?
>=20
> - k
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>=20
