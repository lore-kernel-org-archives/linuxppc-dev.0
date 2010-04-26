Return-Path: <ron_madrid@sbcglobal.net>
Received: from web83502.mail.sp1.yahoo.com (web83502.mail.sp1.yahoo.com
	[216.252.120.158]) by ozlabs.org (Postfix) with SMTP id 1CA47B7D59
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Apr 2010 04:04:48 +1000 (EST)
Message-ID: <681077.39599.qm@web83502.mail.sp1.yahoo.com>
Date: Mon, 26 Apr 2010 11:04:47 -0700 (PDT)
From: Ron Madrid <ron_madrid@sbcglobal.net>
Subject: MPC8313: fsl_elbc_nand and MDR
To: linuxppc-dev@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I am having what appears to be a little conflict
with this driver, particularly with the MDR.  My
hardware uses NAND flash and an FPGA connected
through the UPM.  After the kernel is up and
running, sometimes I cannot verify the data in
the UPM RAM array.  I am guessing right now that
this is due to a use conflict between my
application and the fsl_elbc_nand driver both
trying to use the MDR at once.

Is there currently any sort of coordination that
exists for the MDR in the fsl_elbc_nand driver?
I have been looking through the code and have
not been able to find any.

Any ideas on how to solve this would be
appreciated as well.

Ron
