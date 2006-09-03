Return-Path: <wigyori@uid0.hu>
Received: from smtp01.megaweb.hu (ivymike.megaweb.hu [195.228.155.87])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7EC4267BA2
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Sep 2006 02:08:15 +1000 (EST)
Received: from [195.38.112.166] (port=1055 helo=[10.1.1.20])
	by smtp01.megaweb.hu with esmtpsa (Exim 4.60 #1 (Debian))
	id 1GJtzs-0001pp-Re from <wigyori@uid0.hu>
	for <linuxppc-embedded@ozlabs.org>; Sun, 03 Sep 2006 17:34:57 +0200
Message-ID: <44FAF68F.1080206@uid0.hu>
Date: Sun, 03 Sep 2006 17:36:47 +0200
From: Zoltan HERPAI <wigyori@uid0.hu>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Serial problem with MPC8241-based board
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I've recently acquired an Allnet 6250 NAS, which has an MPC8241-based 
board. Since its GPL tarball is not available fully, I began to build a 
toolchain based on gcc-3.4.6 and binutils-2.16.1, and an up-to-date 
kernel for it. PPCboot states that this is a Sandpoint 8241 Unity board, 
so the platforms/sandpoint.* was chosen as a starting point, however, 
after rewriting the irq and ioport values in sandpoint.h to the ones 
(irq 137, ioport 0x80004500), no output came out of the serial port. 
After a few days of tweaking around with variables is sandpoint.h, a 
google session revealed that this board is 99% the same as the Buffalo 
Linkstation's is, which has a 2.6.x port also, but those kernels are 
also failing to display any output.
Can anyone shed some light on what points should I check and what may I 
have done wrong?

Regards,
Zoltan HERPAI
