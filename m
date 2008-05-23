Return-Path: <Agostino.Sette@technolabs.it>
Received: from smtp.technolabs.it
	(host20-155-static.82-213-b.business.telecomitalia.it
	[213.82.155.20]) by ozlabs.org (Postfix) with ESMTP id 1D039DE0E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 19:32:10 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: Building Cross Compiler for MPC8260ADS
Date: Fri, 23 May 2008 11:19:57 +0200
Message-ID: <F1F6EC0C8B75034F9E3A79FC85122E8EED96B8@aquib01a>
In-Reply-To: <17421912.post@talk.nabble.com>
From: "SETTE AGOSTINO - technolabs" <Agostino.Sette@technolabs.it>
To: "Misbah khan" <misbah_khan@engineer.com>,
	<linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Misbah,

This is off topic here. Please post on the u-boot-users mailing
list instead.

Regards
Agostino Sette

> -----Original Message-----
> From: =
linuxppc-embedded-bounces+agostino.sette=3Dtechnolabs.it@ozlabs.org =
[mailto:linuxppc-embedded-
> bounces+agostino.sette=3Dtechnolabs.it@ozlabs.org] On Behalf Of Misbah =
khan
> Sent: venerd=EC 23 maggio 2008 11.16
> To: linuxppc-embedded@ozlabs.org
> Subject: Building Cross Compiler for MPC8260ADS
>=20
>=20
> Hi all
>=20
> I need to built the cross compiler for MPC8260ADS to compile it for =
target
> board. The u-boot which i am using is version 1.1.6. I need to make =
the
> u-boot configuration and flash the image. I already have a ppc =
crosscompiler
> but it is giving this error message :-
>=20
> make: powerpc-linux-gcc: Command not found
> for dir in tools examples post post/cpu ; do make -C $dir _depend ; =
done
> make[1]: powerpc-linux-gcc: Command not found
> make[1]: Entering directory =
`/cashel/home/spx/misbah/u-boot-1.1.6/tools'
> ln -s ../common/environment.c environment.c
> ln -s ../lib_generic/crc32.c crc32.c
> make[1]: Leaving directory =
`/cashel/home/spx/misbah/u-boot-1.1.6/tools'
> make[1]: powerpc-linux-gcc: Command not found
> make[1]: Entering directory =
`/cashel/home/spx/misbah/u-boot-1.1.6/tools'
> make[1]: Nothing to be done for `_depend'.
> make[1]: Leaving directory =
`/cashel/home/spx/misbah/u-boot-1.1.6/tools'
> make[1]: powerpc-linux-gcc: Command not found
> make[1]: Entering directory =
`/cashel/home/spx/misbah/u-boot-1.1.6/examples'
> /bin/sh: powerpc-linux-gcc: command not found
> dirname: too few arguments
> Try `dirname --help' for more information.
> /bin/sh: powerpc-linux-gcc: command not found
> dirname: too few arguments
> Try `dirname --help' for more information.
> /bin/sh: powerpc-linux-gcc: command not found
> /bin/sh: powerpc-linux-gcc: command not found
> /bin/sh: powerpc-linux-gcc: command not found
>=20
>=20
>=20
> Can any one tell me How to get the Cross compiler for MPC8260ADS and =
how to
> built it ...
>=20
> Please do share your experience in this regard ...
>=20
> Thanks in Advance
> Misbah <><
> --
> View this message in context: =
http://www.nabble.com/Building-Cross-Compiler-for-MPC8260ADS-
> tp17421912p17421912.html
> Sent from the linuxppc-embedded mailing list archive at Nabble.com.
>=20
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
