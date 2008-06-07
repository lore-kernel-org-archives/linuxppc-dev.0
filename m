Return-Path: <sam.d.karp@gmail.com>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.157])
	by ozlabs.org (Postfix) with ESMTP id 825C5DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Sun,  8 Jun 2008 08:29:13 +1000 (EST)
Received: by fg-out-1718.google.com with SMTP id d23so1100488fga.39
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 07 Jun 2008 15:29:11 -0700 (PDT)
Message-ID: <800687fe0806071529j16cc360bub252c492975368ea@mail.gmail.com>
Date: Sat, 7 Jun 2008 16:29:10 -0600
From: "Sam Karp" <sam.d.karp@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Linux w/o UBoot from Linear Flash
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I currently have a linux ramdisk image (zImage.initrd.elf) stored in
linear flash.  I also have a bit file with the xilinx EDK generated
bootloader in platform flash on an ML403.   Is it neccessary to have
uboot with the linux kernel to be able to boot automatically or can i
simply alter the xilinx bootloader (if needed at all? )

Thanks,
Sam
