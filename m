Return-Path: <wei.li4@elf.mcgill.ca>
Received: from torrent.cc.mcgill.ca (torrent.CC.McGill.CA [132.206.27.49])
	by ozlabs.org (Postfix) with ESMTP id CEBEC67BC6
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Sep 2006 04:20:56 +1000 (EST)
Received: from mailscan2.cc.mcgill.ca (mailscan2.CC.McGill.CA [132.216.77.249])
	by torrent.cc.mcgill.ca (8.12.11/8.12.3) with ESMTP id k85IKqWE017295
	for <linuxppc-embedded@ozlabs.org>; Tue, 5 Sep 2006 14:20:52 -0400
Received: from wgrappe1.cc.mcgill.ca (wgrappe1.CC.McGill.CA [132.216.46.250])
	by mailscan2.cc.mcgill.ca (8.13.6/8.13.0) with ESMTP id
	k85IKnLv011327
	for <linuxppc-embedded@ozlabs.org>; Tue, 5 Sep 2006 14:20:49 -0400 (EDT)
Received: from wgrappe1.cc.mcgill.ca (localhost.localdomain [127.0.0.1])
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.4) with ESMTP id k85IKnWI009562
	for <linuxppc-embedded@ozlabs.org>; Tue, 5 Sep 2006 14:20:49 -0400
Received: (from apache@localhost)
	by wgrappe1.cc.mcgill.ca (8.13.7/8.13.7/Submit) id k85IKnm8009559
	for linuxppc-embedded@ozlabs.org; Tue, 5 Sep 2006 14:20:49 -0400
Message-ID: <20060905142049.p4ramon49sk4kco4@webmail.mcgill.ca>
Date: Tue, 05 Sep 2006 14:20:49 -0400
From: wei.li4@elf.mcgill.ca
To: linuxppc-embedded@ozlabs.org
Subject: Compile Error
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
