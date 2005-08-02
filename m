Return-Path: <Baohua.WANG@alcatel-sbell.com.cn>
MIME-Version: 1.0
Content-Type: text/plain;
	charset=gb2312
Date: Tue, 2 Aug 2005 11:28:20 +0800
Message-ID: <A9DE2BAF233E444FA9C5E77A5825A01E8652FC@ydmail.sbell.com.cn>
From: "FCG WANG Baohua" <Baohua.WANG@alcatel-sbell.com.cn>
To: "Debora Liu" <deboralh@fel.com.cn>
Cc: Linuxppc-embedded <Linuxppc-embedded@ozlabs.org>
Subject: =?gb2312?b?tPC4tDogQmFkIE1hZ2ljIE51bWJlciB3aGVuIGJvb3QgbGludXgg?=
	=?gb2312?b?a2VybmVsIHdpdGggcHBjYm9vdCAoUFBDODYwIGJvYXJkKQ==?=
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Mr Liu:
 I have corrected it, Now another question:
 when bootm or imi , it shows the "Verifying Checksum ... Bad Data CRC", =
But I checked the vmlinux.UBoot on host, it is right,
 I download it using TFTP, How can I slove it? Thanks!


-----=D4=AD=CA=BC=D3=CA=BC=FE-----
=B7=A2=BC=FE=C8=CB: Debora Liu [mailto:deboralh@fel.com.cn]
=B7=A2=CB=CD=CA=B1=BC=E4: 2005=C4=EA8=D4=C22=C8=D5 11:17
=CA=D5=BC=FE=C8=CB: FCG WANG Baohua
=B3=AD=CB=CD: Linuxppc-embedded
=D6=F7=CC=E2: Re: Bad Magic Number when boot linux kernel with ppcboot =
(PPC860
board)


Hello, FCG WANG Baohua

In message <2005-08-02 10:08:35 Baohua.WANG@alcatel-sbell.com.cn> you =
wrote:

>Dear All:
>  I use a PPC860 board and ELDK 3.1.1 (kernel 2.4.25) to boot the linux =
kernel, after I loaded it print the following messages:
>
>=3D> bootm 0x180000
>## Booting image at 00000000 ...
>Bad Magic Number
>=3D>
Please check your boot load image address.

				=20
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1Debora Liu
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1deboralh@fel.com.cn
=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A1=A12005-08-02
