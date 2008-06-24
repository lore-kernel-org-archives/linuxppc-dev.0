Return-Path: <petermendham@computing.dundee.ac.uk>
Received: from uncle.computing.dundee.ac.uk (unknown [134.36.36.11])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ADAFBDDEF5
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 24 Jun 2008 19:08:18 +1000 (EST)
Received: from mailex.computing.dundee.ac.uk (mailex.computing.dundee.ac.uk
	[134.36.36.15])
	by uncle.computing.dundee.ac.uk (8.13.1/8.13.1) with ESMTP id
	m5O92QuA019478
	for <linuxppc-embedded@ozlabs.org>; Tue, 24 Jun 2008 10:02:37 +0100
Message-ID: <4860B81F.6070205@computing.dundee.ac.uk>
Date: Tue, 24 Jun 2008 10:02:23 +0100
From: Peter Mendham <petermendham@computing.dundee.ac.uk>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Subject: Linux on Virtex board with ARCH=powerpc
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear all,

I'm trying to boot a 2.6.26-rc6 kernel on a custom Virtex 4 board.  I 
have used the Xilinx utility to generate a device tree and now want to 
generate an image for throwing onto CF for use with a SystemACE (just 
like on the the ML3/4xx boards).  I don't want to use a bootloader (I 
don't really need one).  I saw something on this list about simpleImage, 
"simple" sounded good to me so I thought I'd try that (or did I 
misinterpret what this is for?).  I also don't want the image to be too 
big, I always used to use a zImage under ARCH=ppc. So, two questions, 
which hopefully are easy ones:
1. I did what Grant said in a post to this list about simpleImage, and 
dumped my dts into arch/powerpc/boot/dts and I called it system.dts (for 
now).  I then tried to do make simpleImage.system which ran right 
through to final link then moaned about a missing simpleboot-system.  
Where is this supposed to come from?  What am I doing wrong?  I naively 
tried copying simpleboot.o to simpleboot-system.o and the error went 
away.  Hmm.
2. I need an ELF to give to my SystemACE file generator.  This used to 
pop up in arch/ppc/boot/images and be called zImage.elf, which made 
sense to me.  What's the deal now with powerpc?  What should I be using?
Finally, can anyone give me a heads-up on any gotchas with what I'm 
trying to do.  As you can tell, I don't entirely know what I'm doing, so 
any pointers would be gratefully received.

Thanks,
-- Peter


The University of Dundee is a Scottish Registered Charity, No. SC015096.
