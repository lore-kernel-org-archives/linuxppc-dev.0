Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id A603BDDE1B
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 19:00:08 +1100 (EST)
Received: from localhost (nausicaa2.coritel.it [127.0.0.1])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 352BC434005
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 08:59:04 +0100 (CET)
Received: from nausicaa2.coritel.it ([127.0.0.1])
	by localhost (nausicaa2.coritel.it [127.0.0.1]) (amavisd-new,
	port 10024)
	with ESMTP id O1Xlpjty2TCY for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 08:59:03 +0100 (CET)
Received: from [192.168.2.2] (217-133-82-13.b2b.tiscali.it [217.133.82.13])
	by nausicaa2.coritel.it (Postfix) with ESMTP id 2F065434001
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 08:59:03 +0100 (CET)
Message-ID: <47E8B19B.10705@coritel.it>
Date: Tue, 25 Mar 2008 09:02:35 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
Subject: MPC8641D PCI-Express problem
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

do you remember my problem with the pci-express? I have an mpc8641d_hpcn 
(rev. 2.0) board connected via pci-express with the Xilinx ML555 
evaluation board. I'm using the 2.6.24 kernel. I'm observing this 
strange behavior:

1) I turn on the board and I stop the U-boot
2) I load the FPGA microcode
3) I start the system
4) I load the driver module and I read a version register in the FPGA
5) The system crashes with a "machine check exception: transfer error 
ack signal"
6) reboot
7) same procedure (without load the FPGA again)
8) now I can read the registers!

If I repeat the procedure again it doesn't work anymore. I think it's a 
problem with pci-express controller. Have you got any suggestions?

Thanks.

Marco
