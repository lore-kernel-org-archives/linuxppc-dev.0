Return-Path: <kashiwagi@co-nss.co.jp>
Received: from nssinet2.co-nss.co.jp (nssinet2.co-nss.co.jp [150.96.0.5])
	by ozlabs.org (Postfix) with ESMTP id 5E26067F24
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 14:40:00 +1100 (EST)
Received: from nssinet2.co-nss.co.jp (localhost [127.0.0.1])
	by nssinet2.co-nss.co.jp (8.9.3/3.7W) with ESMTP id LAA24998
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Nov 2006 11:54:29 +0900 (JST)
MIME-Version: 1.0
Date: Tue, 21 Nov 2006 11:59:00 +0900
Subject: Re: Memec v4fx12lc - problem booting linux on ppc
From: Yoshio Kashiwagi <kashiwagi@co-nss.co.jp>
To: goudard@esrf.fr, linuxppc-embedded@ozlabs.org
Message-ID: <JG200611211159003.3859000@co-nss.co.jp>
Content-Type: text/plain; charset=ISO-2022-JP
In-Reply-To: <1164022946.8340.6.camel@l-cb312-1.esrf.fr>
References: <1164022946.8340.6.camel@l-cb312-1.esrf.fr>
Cc: andy.gotz@esrf.fr
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Olivier San,

The address of each device driver of LSP of MontaVista Linux and the
address of each IP of the generated circuit match?

Although your detailed environment is not known, the general way of
investigating is as follows.

Check where the processor was stopped by the stop command and the
processor has stopped after runing from xmd.
If compared with stopped address and the address of System.map or
disassembling list of vmlinux, it should be able to be decided by
which processing it has hangs.
Disassembling of vmlinux can be displayed by powerpc-linux-objdump -D 
vmlinux.

Best Regards,

Yoshio Kashiwagi - Nissin Systems

> Hi,
> 
> we have a v4fx12lc fpga board from memec which we are trying to get
> Linux to boot on the ppc processor. We have generated a linux kernel 
for
> nfs using the MontaVista support package. We generate a bitfile with 
the
> following hardware peripherals in it :
> 
> RS232
> Ethernet_MAC
> Led_4bit
> Push_buttons_3bits
> DIP_switches_8bit
> OPB_INTC_0
> 
> When we download the linux image with xmd we see nothing on the screen.
> When we type "run" nothing appears on the screen and Linux does not
> boot.
> 
> Has anyone had a similar problem ? We are stuck! Any ideas would be
> appreciated.
> 
> We can boot a linux ramdisk kernel provided by Memec on the same board
> using their bitfile. So the board seems to be working in general.
> 
> Thansk for any pointers and excuse us if we are posting to the wrong
> list (this is the only list we could find which seemed useful) ! 
> 
> Olivier Goudard
