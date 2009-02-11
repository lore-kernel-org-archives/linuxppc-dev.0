Return-Path: <phenning@vastech.co.za>
Received: from www6.jnb1.host-h.net (www6.jnb1.host-h.net [196.22.132.6])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DFFB6DDDA1
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 00:04:37 +1100 (EST)
Received: from [196.213.226.33] (helo=[172.16.63.116])
	by www6.jnb1.host-h.net with esmtpa (Exim 4.66)
	(envelope-from <phenning@vastech.co.za>) id 1LXElI-0007K7-D2
	for linuxppc-dev@ozlabs.org; Wed, 11 Feb 2009 15:04:21 +0200
Message-ID: <4992CCCF.1020008@vastech.co.za>
Date: Wed, 11 Feb 2009 15:04:15 +0200
From: Pieter <phenning@vastech.co.za>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: Need help with kernel config to set MTD partitions
Content-Type: multipart/signed; protocol="application/x-pkcs7-signature";
	micalg=sha1; boundary="------------ms040406040209030808090802"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a cryptographically signed message in MIME format.

--------------ms040406040209030808090802
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi all

Im Trying to boot a MPC8548 board using CRAMFS ( I am able to boot a
network file system). Im using the powerpc architecture and flattened
device tree containing my flash partitions.  the previous linux i booted
using CRAMFS used mtd/map definition for my board. do i still need to
define a mdt map if I'm using a flattened device tree?

How do i configure the kernal to  use CFI and configure teh MTD
partitions i have? do i use
CONFIG_MTD_PHYSMAP or CONFIG_MTD_PHYSMAP_OF.
as far as i understand to use the mtd/maps I would use
CONFIG_MTD_COMPLEX_MAPPINGS.

Are the config settings for the FTD and mtd/maps mutually exclusive?

my current config regarding CFI and MTD looks as follows"

CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=3
CONFIG_MTD_CONCAT=y
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_REDBOOT_PARTS is not set
##CONFIG_MTD_OF_PARTS=m
# CONFIG_MTD_AR7_PARTS is not set
CONFIG_MTD_CMDLINE_PARTS=y

CONFIG_MTD_CHAR=y
CONFIG_MTD_BLKDEVS=y
CONFIG_MTD_BLOCK=y
CONFIG_MTD_BLOCK_RO=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set
# CONFIG_RFD_FTL is not set
# CONFIG_SSFDC is not set
CONFIG_MTD_OOPS=m
-
# RAM/ROM/Flash chip drivers
#
CONFIG_MTD_CFI=y
#CONFIG_MTD_JEDECPROBE=m
CONFIG_MTD_GEN_PROBE=y
# CONFIG_MTD_CFI_ADV_OPTIONS is not set
#CONFIG_MTD_MAP_BANK_WIDTH_1=y
#CONFIG_MTD_MAP_BANK_WIDTH_2=y
CONFIG_MTD_MAP_BANK_WIDTH_4=y
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
#CONFIG_MTD_CFI_I1=y
CONFIG_MTD_CFI_I2=y
# CONFIG_MTD_CFI_I4 is not set
# CONFIG_MTD_CFI_I8 is not set
# CONFIG_MTD_CFI_INTELEXT is not set
CONFIG_MTD_CFI_AMDSTD=y
CONFIG_MTD_CFI_AMDSTD_RETRY=0
#CONFIG_MTD_CFI_STAA=m
CONFIG_MTD_CFI_UTIL=y
#CONFIG_MTD_RAM=m
CONFIG_MTD_ROM=y
##CONFIG_MTD_ABSENT=m

 Mapping drivers for chip access
#
#CONFIG_MTD_COMPLEX_MAPPINGS=y
#CONFIG_MTD_PHYSMAP=y
CONFIG_MTD_PHYSMAP_OF=y
# CONFIG_MTD_PCI is not set
# CONFIG_MTD_INTEL_VR_NOR is not set
#CONFIG_MTD_PLATRAM=m

thanks pieter

--------------ms040406040209030808090802
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
4IVFG1mBxnkmIDO61P+kVwAAAAAAAA==
--------------ms040406040209030808090802--
