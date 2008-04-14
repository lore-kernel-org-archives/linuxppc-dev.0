Return-Path: <ulf.samuelsson@atmel.com>
Received: from bagnes.atmel.com (smtpeu1.atmel.com [195.65.72.27])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 416D8DE008
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Apr 2008 15:12:24 +1000 (EST)
Message-ID: <000b01c89eb5$2af81630$070514ac@atmel.com>
From: "Ulf Samuelsson" <ulf.samuelsson@atmel.com>
To: "Guillaume Dargaud" <dargaud@lpsc.in2p3.fr>, <linuxppc-dev@ozlabs.org>,
	"Buildroot Mailinglist, " <buildroot@uclibc.org>
References: <014701c89bda$09380060$ad289e86@LPSC0173W><fa686aa40804110655x48120e84tde01a52d8bb39a3@mail.gmail.com>
	<01e801c89e49$6d0e6400$ad289e86@LPSC0173W>
Subject: Re: [Buildroot] zImage.embedded
Date: Mon, 14 Apr 2008 22:55:03 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> [cross posting from one mailing list to another]
>=20
>>>  is the file zImage.elf my proper network image ?
>>
>> What bootloader is on your board?  zImage.elf *might* be the proper
>> image.  If you're using u-boot, then you want to build a uImage
>> instead.
>=20
> I'm trying to compile u-boot with buildroot, but it fails with:
>=20
>                /usr/bin/make -j1 -C=20
> =
/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc/=
genepy/u-boot-1.3.2=20
> \
>                ""_config
> make[1]: Entering directory=20
> =
`/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc=
/genepy/u-boot-1.3.2'
> make[1]: *** No rule to make target `_config'.  Stop.
> make[1]: Leaving directory=20
> =
`/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc=
/genepy/u-boot-1.3.2'
> make: ***=20
> =
[/home/guinevere/Min_UartLite_NetLite_Ace/buildroot/project_build_powerpc=
/genepy/u-boot-1.3.2/.configured]=20
> Error 2
>=20
> Apparently it expects a BOARD_NAME variable, but I don't know what to =
put in=20
> it (I looked at the makefile and can't find the ml405 referenced in =
there).
> --=20
> Guillaume Dargaud
> http://www.gdargaud.net/
>=20


I think you need to figure out how to build u-boot for your board
outside buildroot, before you try to build it inside buildroot.


Best Regards
Ulf Samuelsson
