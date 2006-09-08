Return-Path: <wei.li4@elf.mcgill.ca>
Received: from drizzle.cc.mcgill.ca (drizzle.cc.mcgill.ca [132.206.27.48])
	by ozlabs.org (Postfix) with ESMTP id 6BE9767B9C
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  9 Sep 2006 01:16:48 +1000 (EST)
Received: from mailscan1.cc.mcgill.ca (mailscan1.CC.McGill.CA [132.216.77.248])
	by drizzle.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k88FGj5g030774
	for <linuxppc-embedded@ozlabs.org>; Fri, 8 Sep 2006 11:16:47 -0400
Received: from wgrappe2.cc.mcgill.ca (wgrappe2.CC.McGill.CA [132.216.46.251])
	by mailscan1.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k88FGRMt014337
	for <linuxppc-embedded@ozlabs.org>; Fri, 8 Sep 2006 11:16:27 -0400 (EDT)
Received: from wgrappe2.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe2.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k88FGQDd021067
	for <linuxppc-embedded@ozlabs.org>; Fri, 8 Sep 2006 11:16:26 -0400
Received: (from apache@localhost)
	by wgrappe2.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k88FGQAS021064
	for linuxppc-embedded@ozlabs.org; Fri, 8 Sep 2006 11:16:26 -0400
Message-ID: <20060908111626.6gb5jqt9mo04o44o@webmail.mcgill.ca>
Date: Fri, 08 Sep 2006 11:16:26 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Compile Error Report
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

I am working on linux-2.6.18-rc2-g73a589b5.tar.bz2 for MPC875, the 
cross-tools are from ELDK 4.0. After configuration and do 'make 
zImage', I got these error:

CC      arch/ppc/boot/simple/m8xx_tty.o
arch/ppc/boot/simple/m8xx_tty.c:32: error: static declaration of 'cpmp' 
follows non-static declaration
include/asm/commproc.h:74: error: previous declaration of 'cpmp' was here
make[2]: *** [arch/ppc/boot/simple/m8xx_tty.o] Error 1

I also got these errors if I used these tools on Linux 2.6.13, but 
there is no error if I use tools from ELDK 3.1.1, can anyone help me 
figure it out? Thanks.

Wei
