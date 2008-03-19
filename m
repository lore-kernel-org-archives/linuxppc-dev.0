Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D8897DDF86
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Mar 2008 03:17:47 +1100 (EST)
Date: Wed, 19 Mar 2008 11:17:25 -0500
From: Scott Wood <scottwood@freescale.com>
To: ???? <guojin02@tsinghua.org.cn>
Subject: Re: Hi,friends, the question about the u-boot and device tree?
Message-ID: <20080319161725.GK6177@ld0162-tx32.am.freescale.net>
References: <405889728.25141@tsinghua.org.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <405889728.25141@tsinghua.org.cn>
Cc: u-boot-users@lists.sourceforge.net, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, Mar 19, 2008 at 09:22:08AM +0800, ???? wrote:
> My board is MPC8360EMDS, my bootm command is "bootm uImage ramdisk_ppc
> mpc836x_mds.dtb", I used the MPC8360E_PB_K26_20071012-LTIB.iso to generate above
> uImage, ramdisk_ppc,mpc836x_mds.dtb. 

Could you try the latest upstream u-boot, dts, and kernel to see if
things are better?

> If I fill the frequency to zero on mpc836x_mds.dts, 

Which frequency property?  Did you get any device-tree-related error
messages from u-boot?

> I also has another question, I modified the HRCW to config the cpu as 660/330/400
> MHZ during power on, I used the "clocks" command on u-boot to see that the clock
> is real 660/330/400 MHZ, then I changed the frequency value on dts to 660/330/400,
> after the bootm command, the linux was not carshed after serial configuration, but
> the output is random.
> 
> "
> Serial: 8250/16550 driver $Revision: 1.90 $ 4 ports, IRQ sharing disabled
> serial8250.0: ttyS0 at MMIO 0xe0004500 (irq = 16) is a 16550A
> [output from serial is random]
> "
> 
> I have config the frequency both on HRCW and devie tree is the same, why the
> frequency for serial on linux is not right?  Why the 528/260/400 is Ok, the
> 660/330/400 has problem on serial.

What are you putting in the serial nodes' clock-frequency in each case?

-Scott
