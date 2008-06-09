Return-Path: <txtbox@gmail.com>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.242])
	by ozlabs.org (Postfix) with ESMTP id C77D5DDE3A
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 06:09:28 +1000 (EST)
Received: by an-out-0708.google.com with SMTP id c34so466343anc.78
	for <linuxppc-dev@ozlabs.org>; Mon, 09 Jun 2008 13:09:27 -0700 (PDT)
Subject: Making the Kernel
From: Jacob Holladay Poteet <txtbox@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Date: Mon, 09 Jun 2008 15:09:23 -0500
Message-Id: <1213042163.7776.4.camel@Phoebe>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Good Afternoon,

I've gone through the process of configuring a kernel for my Xilinx
board design using the mhs->devtree, dts+'make menuconfig'
options->'make all' process and things seem to have succeeded. I was
under the expectation that I would find a file
arch/powerpc/boot/zImage.virtex, which is a type of .elf file that I can
use to make a bitstream, but I didn't find this said file in the output.
I found several zImage files (zImage,
zImage.pmac,.miboot,.chrp,.lds,.cofflds), but none of them had the
desired '.virtex' extension. Am I looking for something that doesn't
exist? If not, can someone help me generate the necessary file?

This is my first time through this process so I appreciate your advice.

Sincerely,
Jake Poteet
