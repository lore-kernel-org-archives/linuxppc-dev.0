Return-Path: <zhangke@ict.ac.cn>
Received: from ict.ac.cn (webmail.ict.ac.cn [159.226.39.7])
	by ozlabs.org (Postfix) with SMTP id C98ED67A3D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 21 Jun 2006 16:36:20 +1000 (EST)
Date: Wed, 21 Jun 2006 14:29:38 +0800
From: "Zhang Ke" <zhangke@ict.ac.cn>
To: "linuxppc-embedded" <linuxppc-embedded@ozlabs.org>
Subject: uboot and ppc405 
Message-ID: <200606211429388287786@ict.ac.cn>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi,

I want to use Uboot in v2pro for booting linux from xilinx flash PROM. is it doable?

my board is a custom board, which has a XC2VP20, XCF32P, DDR, UART

at present, i can run a open core linux on the board by JTAG and UART. but i must use iMPACT to download bit file(about 0.97MB), use XMD to download elf file(about 4.43MB). this is too slow :(

can i use flash PROM to store these two files? and when power on, the UBoot can download them automatically and orderly to FPGA?

I found the XAPP542 from xilinx, but it use UBoot to config FPGA from the files stored in SystemACE Compact Flash Card. Unfortunately, my board does NOT has SystemACE:(

I also want to ask you that whether my XCF32P(32 Mbit=4MB) is large enough for storing the whole things?


Help me :(
Thank you :)
			
--------------
Zhang Ke
2006-06-21
