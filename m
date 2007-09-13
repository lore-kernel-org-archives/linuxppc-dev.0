Return-Path: <laurentp@cse-semaphore.com>
Received: from mailrelay007.isp.belgacom.be (mailrelay007.isp.belgacom.be
	[195.238.6.173]) by ozlabs.org (Postfix) with ESMTP id E9888DDE10
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Sep 2007 18:40:02 +1000 (EST)
From: Laurent Pinchart <laurentp@cse-semaphore.com>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Flash Filesystem
Date: Thu, 13 Sep 2007 10:39:55 +0200
References: <46E0FEF3.8010500@fz-juelich.de>
In-Reply-To: <46E0FEF3.8010500@fz-juelich.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200709131039.56077.laurentp@cse-semaphore.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Georg,

On Friday 07 September 2007 09:34, schardt wrote:
> Hi
>
> i've some problems using the on board flash memory with linux.
> i added the support for adm/fujittsu flash in kernel config and add the
> right parameters for the "cfi  flash device in physical memory".
>
> cat /proc/mtd gives me
>
> dev:    size   erasesize  name
> mtd0: 00400000 00010000 "physmap-flash.0"
>
> i added /dev/mtd0 c 90 0 and /dev/mtdblock0 b 31 0
>
> how do i add a partition and filesystem ????
> fdisk /dev/mtd0  seems me not to be correct :)

There are several ways to definie partitions on an MTD device. Make sure yo=
u=20
enable the 'MTD partitioning support' option and have a look at 'RedBoot=20
partition table parsing' and 'Command line partition table parsing':

Device Drivers
<*> Memory Technology Device (MTD) support
    [*] MTD partitioning support
        < > RedBoot partition table parsing
        < > Command line partition table parsing

Another option is to hardcode the partition table in the platform data for =
the=20
physmap driver.

Best regards,

=2D-=20
Laurent Pinchart
CSE Semaphore Belgium

Chauss=E9e de Bruxelles, 732A
B-1410 Waterloo
Belgium

T +32 (2) 387 42 59
=46 +32 (2) 387 42 75
