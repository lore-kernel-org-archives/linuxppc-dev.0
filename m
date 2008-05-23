Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id E4129DE0E9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 May 2008 19:16:30 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1JzTNy-0005ho-Np
	for linuxppc-embedded@ozlabs.org; Fri, 23 May 2008 02:16:26 -0700
Message-ID: <17421912.post@talk.nabble.com>
Date: Fri, 23 May 2008 02:16:26 -0700 (PDT)
From: Misbah khan <misbah_khan@engineer.com>
To: linuxppc-embedded@ozlabs.org
Subject: Building Cross Compiler for MPC8260ADS
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi all

I need to built the cross compiler for MPC8260ADS to compile it for target
board. The u-boot which i am using is version 1.1.6. I need to make the
u-boot configuration and flash the image. I already have a ppc crosscompiler
but it is giving this error message :-

make: powerpc-linux-gcc: Command not found
for dir in tools examples post post/cpu ; do make -C $dir _depend ; done
make[1]: powerpc-linux-gcc: Command not found
make[1]: Entering directory `/cashel/home/spx/misbah/u-boot-1.1.6/tools'
ln -s ../common/environment.c environment.c
ln -s ../lib_generic/crc32.c crc32.c
make[1]: Leaving directory `/cashel/home/spx/misbah/u-boot-1.1.6/tools'
make[1]: powerpc-linux-gcc: Command not found
make[1]: Entering directory `/cashel/home/spx/misbah/u-boot-1.1.6/tools'
make[1]: Nothing to be done for `_depend'.
make[1]: Leaving directory `/cashel/home/spx/misbah/u-boot-1.1.6/tools'
make[1]: powerpc-linux-gcc: Command not found
make[1]: Entering directory `/cashel/home/spx/misbah/u-boot-1.1.6/examples'
/bin/sh: powerpc-linux-gcc: command not found
dirname: too few arguments
Try `dirname --help' for more information.
/bin/sh: powerpc-linux-gcc: command not found
dirname: too few arguments
Try `dirname --help' for more information.
/bin/sh: powerpc-linux-gcc: command not found
/bin/sh: powerpc-linux-gcc: command not found
/bin/sh: powerpc-linux-gcc: command not found



Can any one tell me How to get the Cross compiler for MPC8260ADS and how to
built it ...

Please do share your experience in this regard ...

Thanks in Advance 
Misbah <><
-- 
View this message in context: http://www.nabble.com/Building-Cross-Compiler-for-MPC8260ADS-tp17421912p17421912.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
