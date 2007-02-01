Return-Path: <saiful.etc@gmail.com>
Received: from nf-out-0910.google.com (nf-out-0910.google.com [64.233.182.186])
	by ozlabs.org (Postfix) with ESMTP id 42D04DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Feb 2007 04:52:39 +1100 (EST)
Received: by nf-out-0910.google.com with SMTP id n15so821141nfc
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 01 Feb 2007 09:52:37 -0800 (PST)
Message-ID: <38b44d590702010952nd58f2dbl45a296e535e35869@mail.gmail.com>
Date: Thu, 1 Feb 2007 23:22:37 +0530
From: "Saiful Khan" <saiful.etc@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: ELDKs Kernel is not printing the printk
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_13454_14886867.1170352357267"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

------=_Part_13454_14886867.1170352357267
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,
i am trying to port linuxppc_2_4_devel into my mpc862/MBX board for the
first time  using eldk-3.1.1 (gcc-3.3.3), as of i know the head_8xx.S is the
first file that executes in kernel
then setup.c and so on...

but when i try to boot the kernel image from ram, i got the last message
from u-boot but i do not get any printk() message from kerne.
so i am unable to debug the kernel also..

please suggest me if i have to concentrate more on some particular section
and proceed, and how to proceed...?

thanking in anticipation
saiful

------=_Part_13454_14886867.1170352357267
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hello,<br>i am trying to port linuxppc_2_4_devel into my mpc862/MBX board for the first time&nbsp; using eldk-3.1.1 (gcc-3.3.3), as of i know the head_8xx.S is the first file that executes in kernel<br>then setup.c and so on...
<br><br>but when i try to boot the kernel image from ram, i got the last message from u-boot but i do not get any printk() message from kerne.<br>so i am unable to debug the kernel also..<br><br>please suggest me if i have to concentrate more on some particular section and proceed, and how to proceed...?
<br><br>thanking in anticipation<br>saiful<br>

------=_Part_13454_14886867.1170352357267--
