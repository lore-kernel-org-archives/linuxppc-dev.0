Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E24D2DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Mar 2008 23:56:00 +1100 (EST)
Message-Id: <7F2C28B9-9B87-4F46-9C57-3666BB8F7EFD@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Marco Stornelli <marco.stornelli@coritel.it>
In-Reply-To: <47E8B19B.10705@coritel.it>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: MPC8641D PCI-Express problem
Date: Tue, 25 Mar 2008 07:55:52 -0500
References: <47E8B19B.10705@coritel.it>
Cc: LinuxPPC-Embedded <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Mar 25, 2008, at 3:02 AM, Marco Stornelli wrote:
> Hi,
>
> do you remember my problem with the pci-express? I have an  
> mpc8641d_hpcn (rev. 2.0) board connected via pci-express with the  
> Xilinx ML555 evaluation board. I'm using the 2.6.24 kernel. I'm  
> observing this strange behavior:
>
> 1) I turn on the board and I stop the U-boot
> 2) I load the FPGA microcode
> 3) I start the system
> 4) I load the driver module and I read a version register in the FPGA
> 5) The system crashes with a "machine check exception: transfer  
> error ack signal"
> 6) reboot
> 7) same procedure (without load the FPGA again)
> 8) now I can read the registers!
>
> If I repeat the procedure again it doesn't work anymore. I think  
> it's a problem with pci-express controller. Have you got any  
> suggestions?
>
> Thanks.

Where are you loading the FPGA microcode (linux, u-boot)?  Also, is  
the FPGA the only device connected over PCIe?

- k
