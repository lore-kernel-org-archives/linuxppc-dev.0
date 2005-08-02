Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
Received: from mail.alcatel-sbell.com.cn (nat1.alcatel-sbell.com.cn
	[202.96.203.177]) by ozlabs.org (Postfix) with ESMTP id 3A1E967E64
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Aug 2005 17:29:36 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset=iso-8859-1
Date: Tue, 2 Aug 2005 15:29:24 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E865051@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: <wd@denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: ??: Bad Magic Number when boot linux kernel with ppcboot (PPC860
	board)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Denk:
  The magic number is right when using vmlinux.UBoot instead of vmlinux =
or zImage, Why?
  Another question puzzle me:
  The kernel print the "Transferring control to Linux (at address =
00000000) ... "  then halt ,no any response from serial port.
  I tried ramdiak and nfs, there are the same result.
  So why not print the=20
  "Linux version 2.4.25 (root at FedoraCore2) (gcc version 3.3.3 (DENX =
ELDK 3.1
3.3.3-8)) #94 Tue Jul 5 18:59:08 PDT 2005"=20
 =20
  How to not print the "Transferring control to Linux (at address =
00000000) ... "  ? Is it right ?=20
  Thanks a lot!


-----????-----
???: wd@denx.de [mailto:wd@denx.de]
????: 2005?8?2? 15:13
???: FCG WANG Baohua
??: linuxppc-embedded@ozlabs.org
??: Re: Bad Magic Number when boot linux kernel with ppcboot (PPC860 =
board)=20


In message <A9DE2BAF233E444FA9C5E77A5825A01E8652F9@ydmail.sbell.com.cn> =
you wrote:
>=20
> kernel, after I loaded it print the following messages:
>=20
> =3D> bootm 0x180000
> ## Booting image at 00000000 ...
> Bad Magic Number
> =3D>

Which address did you load the image to?

> How to slove it, thanks a lot!
> I use:  zImage,=20
> vmlinux.UBoot,
>  vmlinux=20
>  it all print the same messages, How can I do?=20

Please read the documentation. Only uImage =3D vmlinux.UBoot can work.

Best regards,

Wolfgang Denk

--=20
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Confound these ancestors.... They've stolen our best ideas!"
- Ben Jonson
