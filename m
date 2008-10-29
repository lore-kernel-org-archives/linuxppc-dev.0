Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	by ozlabs.org (Postfix) with ESMTP id 058A9DDDDB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 30 Oct 2008 05:32:12 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1KvFpp-0000XN-4x
	for linuxppc-embedded@ozlabs.org; Wed, 29 Oct 2008 11:32:01 -0700
Message-ID: <20233115.post@talk.nabble.com>
Date: Wed, 29 Oct 2008 11:32:01 -0700 (PDT)
From: Stuart Bershtein <sbershtein@quantum3d.com>
To: linuxppc-embedded@ozlabs.org
Subject: GDB, xilinx ml50x
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


Hello all.  I am having difficulty getting gdb6.8 and gdbserver functioning
on a xilinx ml507 evaluation board running linux-2.6-xlnx.git.  Has anyone
done this successfully?  I can get gdb to run a small application but
hitting a breakpoint (or stepping) results in a dead PPC core.  Perhaps
someone has had success with the Xilinx provided powerpc-eabi-gdb.exe?  Is
the this and the gdbserver built into XMD intended for debugging linux
applications?  Thanks in advance for your good counsel.
-- 
View this message in context: http://www.nabble.com/GDB%2C-xilinx-ml50x-tp20233115p20233115.html
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
