Return-Path: <willis@arlut.utexas.edu>
Received: from ns4.arlut.utexas.edu (ns4.arlut.utexas.edu [66.162.93.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 766EEDDE9E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 18 Oct 2007 03:47:32 +1000 (EST)
Received: from ns2.arlut.utexas.edu (ns2.arlut.utexas.edu [146.6.211.1])
	by ns4.arlut.utexas.edu (8.13.7/8.13.7) with ESMTP id l9HHlRqi069200
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 17 Oct 2007 12:47:28 -0500 (CDT)
Subject: Re: MPC85xx and linux IDE driver
From: Michael Brian Willis <willis@arlut.utexas.edu>
To: Ben Warren <bwarren@qstreams.com>
In-Reply-To: <470FCF8A.1000504@qstreams.com>
References: <1192213784.4862.48.camel@louie> <470FCF8A.1000504@qstreams.com>
Content-Type: text/plain
Date: Wed, 17 Oct 2007 12:47:17 -0500
Message-Id: <1192643237.4929.41.camel@louie>
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


On Fri, 2007-10-12 at 15:48 -0400, Ben Warren wrote:
  
> Here's what I use:
> 
> http://marc.info/?l=linux-kernel&m=113877891224982&w=2

Thanks for the response Ben. 

I have put the driver you mentioned in my linux source and added the
necessary information in the Kconfig file and the Makefile. So, I am now
able to build the driver when I make my kernel image. However, I can't
figure out what else needs to be done in order to actually use the
driver for my compact flash device. Do I need to specify anything at the
kernel command line, or do I need to modify any other config files?
(Below is the ide portion of my linux .config file)

Thank you for your help so far, anymore help/direction is greatly
appreciated. 

Regards, 

Michael Willis
Applied Research Labs - University of Texas



#
# ATA/ATAPI/MFM/RLL support
#
CONFIG_IDE=y
CONFIG_IDE_MAX_HWIFS=4
CONFIG_BLK_DEV_IDE=y

#
# Please see Documentation/ide.txt for help/info on IDE drives
#
# CONFIG_BLK_DEV_IDE_SATA is not set
# CONFIG_BLK_DEV_IDEDISK is not set
# CONFIG_IDEDISK_MULTI_MODE is not set
# CONFIG_BLK_DEV_IDECD is not set
# CONFIG_BLK_DEV_IDETAPE is not set
# CONFIG_BLK_DEV_IDEFLOPPY is not set
CONFIG_IDE_TASK_IOCTL=y

#
# IDE chipset support/bugfixes
#
CONFIG_IDE_GENERIC=y
# CONFIG_BLK_DEV_IDEPCI is not set
# CONFIG_IDE_ARM is not set
CONFIG_BLK_DEV_CFIDE=y
# CONFIG_BLK_DEV_IDEDMA is not set
# CONFIG_BLK_DEV_HD is not set
