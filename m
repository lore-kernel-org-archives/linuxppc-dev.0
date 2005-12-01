Return-Path: <nathael.pajani@cpe.fr>
Received: from smtp-out.completel.net (smtp-out.completel.net [83.145.110.36])
	by ozlabs.org (Postfix) with ESMTP id 4411668872
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  2 Dec 2005 02:38:09 +1100 (EST)
Received: from [192.52.109.152] (unknown [83.145.98.3])
	by smtp-out.completel.net (Postfix) with ESMTP id 57A06280066
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Dec 2005 16:38:08 +0100 (CET)
Message-ID: <438F198F.9020606@cpe.fr>
Date: Thu, 01 Dec 2005 16:41:03 +0100
From: Nathael PAJANI <nathael.pajani@cpe.fr>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: Re: MPC8555 8280/8270 USB host support
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

 >
 >>
 >>Don't you think u-boot should take care of clock setup
 >>i.e. as much as possible of all board dependent stuff ?
 >>
 >>
 >I think you're right, but then it was easier to make all these setups 
 >in the driver itself.
 >

If u-boot is the boot loader of your board (the stuff running on it 
--before-- we see this:

loaded at:     00400000 005153B4
board data at: 00513130 00513334
relocated to:  00405090 00405294
zimage at:     00405A85 00512099
avail ram:     00516000 08000000

Linux/PPC load: rw console=ttyS0 root=/dev/nfs ip=on

Uncompressing Linux...done)


Then I would say NO




If u-boot is this exact stuff (the files in arch/ppc/boot/simple/... 
misc-embedded.c for example)

then, yes, this is somehow better.
But (tell me if I'm wrong) this is not really Linux code, and this 
should be done by Linux.


What I think should be good also is the platform files 
(arch/ppc/platforms/....) for this is the place where all the board 
dependant stuff stays.




Maybe I'm completely mistaken.
Feel free to tell me (and explain please !)

Have fun.
