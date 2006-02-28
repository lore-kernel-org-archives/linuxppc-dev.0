Return-Path: <k_shivanii@yahoo.com>
Received: from web32108.mail.mud.yahoo.com (web32108.mail.mud.yahoo.com
	[68.142.207.122]) by ozlabs.org (Postfix) with SMTP id 9DAA567A00
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Feb 2006 18:13:51 +1100 (EST)
Message-ID: <20060228071349.38338.qmail@web32108.mail.mud.yahoo.com>
Date: Mon, 27 Feb 2006 23:13:49 -0800 (PST)
From: shivani kirubanandan <k_shivanii@yahoo.com>
Subject: help regarding my kernel compilation for powerpc 405-xilinxml300
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hello,
intially the compiler was
unable to find xiic_l.h file ...so i went to
arch/ppc/boot/simple/embed_config.c

and gave the entire path for the file to be
#include<home/shivani/downloads/linux-2.4.26/drivers/i2c/xilinx_iic/xiic_l.h>

after which this error has occured,am not sure where
the path ent wrong i again tried changing the path for
this file (xbasic_types.h) but the error persists
help me out plz.


xiic_l.h:64:85:
home/shivani/downloads/linux-2.4.26/drivers/i2c/xilinx_iic/xbasic_types.h:
No such file or directory
make[3]: *** [i2c-algo-xilinx.o] Error 1
make[3]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/drivers/i2c/xilinx_iic'
make[2]: *** [_subdir_xilinx_iic] Error 2
make[2]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/drivers/i2c'
make[1]: *** [_subdir_i2c] Error 2
make[1]: Leaving directory
`/home/shivani/downloads/linux-2.4.26/drivers'
make: *** [_dir_drivers] Error 2


thanks in advance 

shivani


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
