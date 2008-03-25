Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 001A4DDFCF
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Mar 2008 00:01:18 +1100 (EST)
Message-ID: <47E8F836.9060603@coritel.it>
Date: Tue, 25 Mar 2008 14:03:50 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8641D PCI-Express problem
References: <47E8B19B.10705@coritel.it>
	<7F2C28B9-9B87-4F46-9C57-3666BB8F7EFD@kernel.crashing.org>
In-Reply-To: <7F2C28B9-9B87-4F46-9C57-3666BB8F7EFD@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
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

Kumar Gala ha scritto:
> 
> On Mar 25, 2008, at 3:02 AM, Marco Stornelli wrote:
>> Hi,
>>
>> do you remember my problem with the pci-express? I have an 
>> mpc8641d_hpcn (rev. 2.0) board connected via pci-express with the 
>> Xilinx ML555 evaluation board. I'm using the 2.6.24 kernel. I'm 
>> observing this strange behavior:
>>
>> 1) I turn on the board and I stop the U-boot
>> 2) I load the FPGA microcode
>> 3) I start the system
>> 4) I load the driver module and I read a version register in the FPGA
>> 5) The system crashes with a "machine check exception: transfer error 
>> ack signal"
>> 6) reboot
>> 7) same procedure (without load the FPGA again)
>> 8) now I can read the registers!
>>
>> If I repeat the procedure again it doesn't work anymore. I think it's 
>> a problem with pci-express controller. Have you got any suggestions?
>>
>> Thanks.
> 
> Where are you loading the FPGA microcode (linux, u-boot)?  Also, is the 
> FPGA the only device connected over PCIe?
> 
> - k
> 
I load the FPGA with JTAG and with a Xilinx program without a specific 
linux driver or u-boot. Yes, it is the only device connected over PCIe.

\Marco
