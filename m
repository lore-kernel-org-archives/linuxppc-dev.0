Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it (unknown [82.190.130.254])
	by ozlabs.org (Postfix) with ESMTP id 35BBBDDFB8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 16 May 2008 22:37:28 +1000 (EST)
Message-ID: <482D7BB0.4040505@coritel.it>
Date: Fri, 16 May 2008 14:18:56 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: mojtaba <kernelppc@gmail.com>
Subject: Re: Booting Linux from an ACE File
References: <007a01c8b74c$0ad9c2e0$208d48a0$@com>
In-Reply-To: <007a01c8b74c$0ad9c2e0$208d48a0$@com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

mojtaba ha scritto:
> Dear all,
> 
> Could you please explain what happens exactly when Linux is booting from a
> compact flash?
> 
> To my few knowledge, the Linux compressed image will be copied somewhere in
> memory, will be uncompressed and the control will jump to the beginning
> address of the Linux kernel.
> 
> Is there any boot loader that copies the Linux compressed image to the
> memory?
> 
> Where in memory does it put the Linux kernel? For example, if I have 2 DDRs
> in my hardware, in which of them it will be put the kernel?
> 
> Can I set the kernel location in memory manually?
> 
> Might be an stupid question but: Is it possible for the kernel to be half in
> BRAMS and half in DDR?
> 
> Regards,
> Moji
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 

 > Is there any boot loader that copies the Linux compressed image to the
 > memory?

Yes there are several boot-loader for example U-Boot.

 > Where in memory does it put the Linux kernel? For example, if I have 
2 DDRs in my hardware, in which of them it will be put the kernel?

The kernel usually is copied at the start of the memory, so if you have 
mapped the address 0x00000000 in the first bank, here will be copied it.

 > Can I set the kernel location in memory manually?

Yes but usually it's not needed and you have to be carefully to modify it.
