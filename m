Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 307C8DDD04
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 20 Nov 2007 11:08:08 +1100 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1IuGeq-0004Dy-3S
	for linuxppc-embedded@ozlabs.org; Mon, 19 Nov 2007 16:08:04 -0800
Message-ID: <13848328.post@talk.nabble.com>
Date: Mon, 19 Nov 2007 16:08:03 -0800 (PST)
From: abhi_linux <seema.pm@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: 2.6 kernel hangs after loading device tree
In-Reply-To: <fa84b3da0708290938l40d8f543oc0e34fa9bea806a4@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
References: <fa84b3da0708290938l40d8f543oc0e34fa9bea806a4@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hello
Did u get a solution to this? I have similar issues. How do u enable
debugging in UBoot?
Thanks

charanya venkatraman wrote:
> 
> Hi all
>        Sorry about the previous mail.Got sent  by mistake.
> 
> Iam using the 2.6.22.5 kernel on MPC 8560 and MPC8540 on my custom
> board.Mykernel hangs after loading the device tree in both the
> processors .There is
> no output on the serial port after loading the device tree.Am using U-boot
> 1.2.0 as the bootloader.After enabling debug in u-boot i could see that
> the
> control is getting transferred to the kernel after which it hangs.Earlier
> i
> tried using 2.6.21 which also hangs at the same point.The config files
> used
> were MPC8540ADS_defconfig and MPC8560ADS_defconfig under powerpc
> directory.
> The changes that were made to the device tree are:
> 1.The reg and ranges properties of the soc node have been changed to
> account
> for the change in CCSRBAR of my board.
> 2.Removed the PCI,mdio nodes and ethernet nodes since i dont need support
> for these as of now.
> 
> I have tried the following console arguments:
> MPC8540: bootargs root=/dev/ram rw console=ttyS0,115200
> MPC8560:bootargs root=/dev/ram rw console=ttyCPM0,115200
> 
> Any help on this issue??
> 
> Thanks.
> Charanya.
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

-- 
View this message in context: http://www.nabble.com/2.6-kernel-hangs-after-loading-device-tree-tf4348921.html#a13848328
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
