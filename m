Return-Path: <rimas@cnmat.berkeley.edu>
Received: from cnmat.berkeley.edu (cnmat.CNMAT.Berkeley.EDU [128.32.122.12])
	by ozlabs.org (Postfix) with ESMTP id BAF9067A2E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Sep 2006 06:44:23 +1000 (EST)
Received: from [128.32.122.171] (account rimas [128.32.122.171] verified)
	by cnmat.berkeley.edu (CommuniGate Pro SMTP 5.0.4)
	with ESMTPA id 1977590 for linuxppc-embedded@ozlabs.org;
	Mon, 11 Sep 2006 12:44:22 -0700
Mime-Version: 1.0 (Apple Message framework v752.2)
Message-Id: <1354DD02-657B-4777-8378-BC408DA3D800@cnmat.berkeley.edu>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: linuxppc-embedded@ozlabs.org
From: rimas <rimas@cnmat.berkeley.edu>
Subject: simple ELF bootloader for embedded xilinx linux ?
Date: Mon, 11 Sep 2006 12:44:25 -0700
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Greetings,

i have been prototyping a design using the avnet V4FX12 mini module  
board running linux

i have been NFS mounting my root partition for the time being but now  
i want to use initrd and have a ramdisk with my root partition

i have built a zImage.initrd.elf which i can download with xmd and  
run and it works fine

up until now i've been using the simple bootloader application that  
comes with the Xilinx EDK to boot linux off the flash memory that is  
included on the board

however the EDK bootloader needs the file its booting to be in SREC  
format which takes up close to 3x the space of the ELF file.  when i  
create an SREC file of the image containing the linux kernel and the  
root filesystem, its too big to fit in the flash (4M).  however the  
zImage.initrd.elf file is less than 3 megs in size.

whats the best/easiest way for me to boot from an ELF file in the  
flash ? i'm aware of u-boot but it seems like overkill for this  
application.  however if it would work and the footprint is  
relatively small i could give it a try.  i imagine i could write my  
own bootloader, i just thought i'd ask first to avoid reinventing the  
wheel.

another somewhat related question is whether i can use a portion of  
the flash (the part thats left over after the kernel/root fs image is  
programmed) as nonvolatile storage using the JFFS2 filesystem ?   
anyone have any pointers to information on how to set this up ?

thanks for any and all advice,

-rimas
