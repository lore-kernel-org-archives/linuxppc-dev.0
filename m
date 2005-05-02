Return-Path: <peter.asemann@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4A3A267B50
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  2 May 2005 23:25:58 +1000 (EST)
Received: by fmmailgate04.web.de (8.12.10/8.12.10/webde Linux 0.7) with ESMTP
	id j42DPx30013731
	for <linuxppc-embedded@ozlabs.org>; Mon, 2 May 2005 15:25:59 +0200
Received: from [131.188.52.149] (helo=[131.188.52.149])
	by smtp08.web.de with asmtp (TLSv1:RC4-MD5:128) (WEB.DE 4.105 #282)
	id 1DSavk-0001Y8-00
	for linuxppc-embedded@ozlabs.org; Mon, 02 May 2005 15:25:48 +0200
Message-ID: <42762A58.7090104@web.de>
Date: Mon, 02 May 2005 15:25:44 +0200
From: Peter Asemann <peter.asemann@web.de>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: peter.asemann@web.de
Subject: Linux 2.4.25 from ELDK 3.1 won't compile
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I still didn't manage to compile a kernel. Though I unselected as much 
features as I could, the compiler still isn't happy. Any ideas?

Peter Asemann


make[1]: Entering directory 
`/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/arch/ppc/kernel'

(...)

ppc_8xx-gcc -D__KERNEL__ 
-I/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/include -Wall 
-Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
-fomit-frame-pointer 
-I/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/arch/ppc -fsigned-char 
-msoft-float -pipe -ffixed-r2 -Wno-uninitialized -mmultiple -mstring 
-nostdinc -I /opt/asemann/eldk/usr/lib/gcc-lib/ppc-linux/3.3.3/include 
-DKBUILD_BASENAME=m8xx_setup  -c -o m8xx_setup.o m8xx_setup.c
m8xx_setup.c:64: error: `bd_t' undeclared here (not in a function)
m8xx_setup.c: In function `m8xx_calibrate_decr':
m8xx_setup.c:192: error: `bd_t' undeclared (first use in this function)
m8xx_setup.c:192: error: (Each undeclared identifier is reported only once
m8xx_setup.c:192: error: for each function it appears in.)
m8xx_setup.c:192: error: `binfo' undeclared (first use in this function)
m8xx_setup.c:192: error: parse error before ')' token
m8xx_setup.c:196: error: `IMAP_ADDR' undeclared (first use in this function)
m8xx_setup.c: In function `m8xx_set_rtc_time':
m8xx_setup.c:269: error: `IMAP_ADDR' undeclared (first use in this function)
m8xx_setup.c: In function `m8xx_get_rtc_time':
m8xx_setup.c:279: error: `IMAP_ADDR' undeclared (first use in this function)
m8xx_setup.c: In function `m8xx_restart':
m8xx_setup.c:288: error: `IMAP_ADDR' undeclared (first use in this function)
m8xx_setup.c: In function `m8xx_show_percpuinfo':
m8xx_setup.c:317: error: `bd_t' undeclared (first use in this function)
m8xx_setup.c:317: error: `bp' undeclared (first use in this function)
m8xx_setup.c:319: error: parse error before ')' token
m8xx_setup.c: In function `m8xx_find_end_of_memory':
m8xx_setup.c:377: error: `bd_t' undeclared (first use in this function)
m8xx_setup.c:377: error: `binfo' undeclared (first use in this function)
m8xx_setup.c:380: error: parse error before ')' token
m8xx_setup.c:378: warning: unused variable `__res'
m8xx_setup.c: In function `m8xx_map_io':
m8xx_setup.c:394: error: `IMAP_ADDR' undeclared (first use in this function)
m8xx_setup.c:394: error: `IMAP_SIZE' undeclared (first use in this function)
m8xx_setup.c: In function `platform_init':
m8xx_setup.c:441: error: `bd_t' undeclared (first use in this function)
make[1]: *** [m8xx_setup.o] Error 1
make[1]: Leaving directory 
`/opt/asemann/eldk/ppc_8xx/usr/src/linux-2.4.25/arch/ppc/kernel'
make: *** [_dir_arch/ppc/kernel] Error 2
