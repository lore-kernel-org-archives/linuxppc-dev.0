Return-Path: <willis@arlut.utexas.edu>
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4F66DDDF7
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Aug 2007 02:09:03 +1000 (EST)
Subject: Re: Flash paritioning and JFFS2
From: Michael Brian Willis <willis@arlut.utexas.edu>
To: Mirek23 <miroslaw.dach@psi.ch>
In-Reply-To: <12293748.post@talk.nabble.com>
References: <12293748.post@talk.nabble.com>
Content-Type: text/plain
Date: Thu, 23 Aug 2007 11:08:57 -0500
Message-Id: <1187885337.5160.55.camel@louie>
Mime-Version: 1.0
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 2007-08-23 at 06:36 -0700, Mirek23 wrote:
> Could someone advice me how to configure Linux kernel to make use of the
> Flash (with above mentioned partitions and JFFS2.

The Denx U-boot and Linux Guide (DULG) will tell you how to configure
the kernel for MTD devices and will give some good general information: 
http://www.denx.de/wiki/view/DULG/FlashFilesystemsMTD



> I do not know however which specific options to enable for MTD/JFFS2 since
> it has many sub options.

The following post has some relevant information for your setup:
http://osdir.com/ml/linux.uclinux.devel/2005-12/msg00130.html



> I do not know also where to place:
> -the partition information (which I have mentioned above) 

The partition information probably should go in a file that you create
for your board located at "drivers/mtd/maps/<your_file>.c"
 

> -the start (0xFF800000) and end (0xFFBFFFFF) physical location of my Flash
> memory.

I think this information just needs to be defined in your board's .h
file in u-boot. I don't think you need to specify this in any linux
config files. 



I hope this info helps. 


Regards, 

Michael Willis
Applied Research Labs - University of Texas
willis@arlut.utexas.edu
 
