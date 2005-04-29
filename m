Return-Path: <peter.asemann@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2CDFD679FE
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Apr 2005 01:47:29 +1000 (EST)
Received: by fmmailgate04.web.de (8.12.10/8.12.10/webde Linux 0.7) with ESMTP
	id j3TFlU30021148
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Apr 2005 17:47:30 +0200
Received: from [131.188.52.149] (helo=[131.188.52.149])
	by smtp05.web.de with asmtp (TLSv1:RC4-MD5:128) (WEB.DE 4.105 #282)
	id 1DRXi3-0003pc-00
	for linuxppc-embedded@ozlabs.org; Fri, 29 Apr 2005 17:47:19 +0200
Message-ID: <427256F5.8080903@web.de>
Date: Fri, 29 Apr 2005 17:47:01 +0200
From: Peter Asemann <peter.asemann@web.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: peter.asemann@web.de
Subject: problem compiling linux with ELDK: `bd_t' undeclared
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi there!

I'm having a problem compiling Linux 2.4.25 as included in ELDK version 
3.1 / Build 2004-11-10.

When trying to compile ppc_8xx/usr/src/linux-2.4.25/drivers/char/flash.c 
it throws an error:

ppc_8xx-gcc -D__KERNEL__ 
-I/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer 
-I/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/arch/ppc -fsigned-char 
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring 
-nostdinc -I /opt/asemann/eldk/usr/lib/gcc-lib/ppc-linux/3.3.3/include 
-DKBUILD_BASENAME=flash  -c -o flash.o flash.c
flash.c: In function `flash_init':
flash.c:446: error: `bd_t' undeclared (first use in this function)
flash.c:446: error: (Each undeclared identifier is reported only once
flash.c:446: error: for each function it appears in.)
flash.c:446: error: `bd' undeclared (first use in this function)
flash.c:446: error: parse error before ')' token
make[3]: *** [flash.o] Error 1

It looks like it misses ppcboot.h or something. Is there something I 
need to select in the kernel configuration to get rid of that error?

Thanks for reading,

Peter Asemann
