Return-Path: <peter.ryser@xilinx.com>
Received: from mail84-ash-R.bigfish.com (mail-ash.bigfish.com [206.16.192.253])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3C0E767A05
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Jun 2005 08:07:59 +1000 (EST)
Message-ID: <42A61693.6040707@xilinx.com>
Date: Tue, 07 Jun 2005 14:50:11 -0700
From: Peter Ryser <peter.ryser@xilinx.com>
MIME-Version: 1.0
To: Sanjay Bajaj <sbajaj@tsi-telsys.com>
References: <0007F077BB3476449151699150E8FEA21A7BA4@exchange.tsi-telsys.com>
In-Reply-To: <0007F077BB3476449151699150E8FEA21A7BA4@exchange.tsi-telsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: root fs mount issue: Xilinx System ACE on PCI bus
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Is "Root on NFS" disabled?

- Peter


Sanjay Bajaj wrote:

>Hi! Gurus,
>
>Need some help in understanding root fs mounting. The setup we have here is our hardware has Xilinx Virtex II pro chip that has System ACE hardware connected to a compact flash. The Virtex II Pro is connected to Local PCI bus which is run by PPC 440GX processor. I have ported the driver for xsysace from ml300 config to our hardware (From OPB to PCI). When I boot over nfs, I can easily mount the partictions on the compact flash. The nodes in /dev directory are:
>
>brw-r--r--    1 root     root     254,   0 Jun  3 13:04 xsysacea
>brw-r--r--    1 root     root     254,   1 Jun  3 13:04 xsysacea1
>brw-r--r--    1 root     root     254,   2 Jun  3 13:04 xsysacea2
>
>When I try to boot from the commpact flash, the kernel panics. The edited boot listing is as follows:
>
>=> bootm
>...
>...
>Kernel command line: root=/dev/xsysacea2 rw console=ttyS0,9600 mem=128M
>...
>...
>Partition check:
> xsysacea: xsysacea1 xsysacea2
>System ACE at 0xFFFC1000 mapped to 0xD2070000, irq=26, 500472KB
>...
>...
>VFS: Cannot open root device "xsysacea2" or 00:00
>Please append a correct "root=" boot option
>Kernel panic: VFS: Unable to mount root fs on 00:00
> <0>Rebooting in 180 seconds..
>
>-------
>
>What am I missing here? Any help is appreciated.
>Thanks,
>Sanjay
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
>
>  
>
