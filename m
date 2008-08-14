Return-Path: <sbershtein@Quantum3D.com>
Received: from MAIL-SJC.quantum3d.com (owa-sjc.quantum3d.com [63.150.7.15])
	by ozlabs.org (Postfix) with ESMTP id 3E0E0DDF5C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Aug 2008 13:24:33 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: How to use ramdisk on the ml300?
Date: Wed, 13 Aug 2008 20:24:31 -0700
Message-ID: <8BB04FAC749BD24BBA250E9D09F2F18B20CCAF@MAIL-SJC.quantum3d.com>
References: <931ae8260808132008i1cac2e91kc76c099ecc574cd0@mail.gmail.com>
From: "Stu Bershtein" <sbershtein@Quantum3D.com>
To: "yanlong wang" <killyouatonce@gmail.com>,
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

Yanlong,

As I discovered today, it is not necessary to use u-boot on the ml507 =
board.  I cannot speak with certainty about the ml300.  For the ml507 =
the ramdisk image gets saved as a separate section in the elf file that =
is downloaded with the zImage.  In the ml507 case the image is a gzipped =
ext2 filesystem.  Makes a very tidy package I'm sure you will agree!=20

Stu



-----Original Message-----
From: linuxppc-embedded-bounces+sbershtein=3Dquantum3d.com@ozlabs.org on =
behalf of yanlong wang
Sent: Wed 8/13/2008 8:08 PM
To: linuxppc-embedded@ozlabs.org
Subject: How to use ramdisk on the ml300?
=20
      If i want use ramdisk on the ml300 , i must use u-boot in my =
system ?
     many thanks
_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
