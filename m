Return-Path: <wei.li4@elf.mcgill.ca>
Received: from torrent.cc.mcgill.ca (torrent.CC.McGill.CA [132.206.27.49])
	by ozlabs.org (Postfix) with ESMTP id A447367A3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 30 Aug 2006 07:11:54 +1000 (EST)
Received: from mailscan3.cc.mcgill.ca (mailscan3.CC.McGill.CA [132.216.77.250])
	by torrent.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k7TLBpLq026893
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Aug 2006 17:11:52 -0400
Received: from wgrappe1.cc.mcgill.ca (wgrappe1.CC.McGill.CA [132.216.46.250])
	by mailscan3.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k7TLBcnG002661 for <linuxppc-embedded@ozlabs.org>;
	Tue, 29 Aug 2006 17:11:39 -0400 (EDT)
Received: from wgrappe1.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k7TLBcTk023667
	for <linuxppc-embedded@ozlabs.org>; Tue, 29 Aug 2006 17:11:38 -0400
Received: (from apache@localhost)
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k7TLBcUg023664
	for linuxppc-embedded@ozlabs.org; Tue, 29 Aug 2006 17:11:38 -0400
Message-ID: <20060829171138.y9uuwvfi4gs48ws4@webmail.mcgill.ca>
Date: Tue, 29 Aug 2006 17:11:38 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Help for building linux 2.6.15
MIME-Version: 1.0
Content-Type: text/plain;
	charset=ISO-8859-1;
	format="flowed"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi All,

I am working on ELDK 4.0 package with my evaluation board: A&M MPC875, 
after configuration for my board, and do 'make zImage', I got the 
following errors:

  CC      arch/ppc/syslib/m8xx_setup.o
arch/ppc/syslib/m8xx_setup.c:56: error: 'bd_t' undeclared here (not in 
a function)
arch/ppc/syslib/m8xx_setup.c:62: error: parse error before '*' token
arch/ppc/syslib/m8xx_setup.c:62: warning: function declaration isn't a 
prototype
arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_calibrate_decr':
arch/ppc/syslib/m8xx_setup.c:144: error: 'binfo' undeclared (first use 
in this function)
arch/ppc/syslib/m8xx_setup.c:144: error: (Each undeclared identifier is 
reported only once
arch/ppc/syslib/m8xx_setup.c:144: error: for each function it appears in.)
arch/ppc/syslib/m8xx_setup.c:144: error: parse error before ')' token
arch/ppc/syslib/m8xx_setup.c:148: error: 'IMAP_ADDR' undeclared (first 
use in this function)
arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_set_rtc_time':
arch/ppc/syslib/m8xx_setup.c:216: error: 'IMAP_ADDR' undeclared (first 
use in this function)
arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_get_rtc_time':
arch/ppc/syslib/m8xx_setup.c:226: error: 'IMAP_ADDR' undeclared (first 
use in this function)
arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_restart':
arch/ppc/syslib/m8xx_setup.c:235: error: 'IMAP_ADDR' undeclared (first 
use in this function)
arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_show_percpuinfo':
arch/ppc/syslib/m8xx_setup.c:262: error: 'bp' undeclared (first use in 
this function)
arch/ppc/syslib/m8xx_setup.c:264: error: parse error before ')' token
arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_find_end_of_memory':
arch/ppc/syslib/m8xx_setup.c:327: error: 'binfo' undeclared (first use 
in this function)
arch/ppc/syslib/m8xx_setup.c:328: warning: ISO C90 forbids mixed 
declarations and code
arch/ppc/syslib/m8xx_setup.c:330: error: parse error before ')' token
arch/ppc/syslib/m8xx_setup.c:328: warning: unused variable '__res'
arch/ppc/syslib/m8xx_setup.c: In function 'm8xx_map_io':
arch/ppc/syslib/m8xx_setup.c:344: error: 'IMAP_ADDR' undeclared (first 
use in this function)
arch/ppc/syslib/m8xx_setup.c:344: error: 'IMAP_SIZE' undeclared (first 
use in this function)
make[1]: *** [arch/ppc/syslib/m8xx_setup.o] Error 1

Can anyone help me? Thanks.
