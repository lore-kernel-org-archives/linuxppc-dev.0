Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1D80EDDE00
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 22:01:18 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IW9rG-0007jc-6J
	for linuxppc-dev@ozlabs.org; Fri, 14 Sep 2007 05:01:14 -0700
Message-ID: <12673863.post@talk.nabble.com>
Date: Fri, 14 Sep 2007 05:01:14 -0700 (PDT)
From: sivaji <rameshmrm@gmail.com>
To: linuxppc-dev@ozlabs.org
Subject: Section mismatch warning
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,
         When compiling the kernel 2.6.23-rc4 for our custom board based on
MPC8641, I got following warning messages

WARNING: vmlinux.o(.text+0x169f6): Section mismatch: reference to
.init.data:boot_command_line (between 'note_bootable_part' and
'pmac_restart')
WARNING: vmlinux.o(.text+0x16a02): Section mismatch: reference to
.init.data:boot_command_line (between 'note_bootable_part' and
'pmac_restart')
WARNING: vmlinux.o(.text+0x16a12): Section mismatch: reference to
.init.data:boot_command_line (between 'note_bootable_part' and
'pmac_restart')

 Give some idea to fix these warnings.

by
Sivaji      

-- 
View this message in context: http://www.nabble.com/Section-mismatch-warning-tf4442060.html#a12673863
Sent from the linuxppc-dev mailing list archive at Nabble.com.
