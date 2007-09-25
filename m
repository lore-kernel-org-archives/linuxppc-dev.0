Return-Path: <bounces@nabble.com>
Received: from kuber.nabble.com (kuber.nabble.com [216.139.236.158])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1CCFCDDE19
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 25 Sep 2007 16:01:58 +1000 (EST)
Received: from isper.nabble.com ([192.168.236.156])
	by kuber.nabble.com with esmtp (Exim 4.63)
	(envelope-from <bounces@nabble.com>) id 1Ia3UZ-00080W-5N
	for linuxppc-embedded@ozlabs.org; Mon, 24 Sep 2007 23:01:55 -0700
Message-ID: <12873633.post@talk.nabble.com>
Date: Mon, 24 Sep 2007 23:01:55 -0700 (PDT)
From: Nethra <nethra_gmit@yahoo.co.in>
To: linuxppc-embedded@ozlabs.org
Subject: jffs2 file system on MPC8272ADS
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


hi everyone, 

I m using custom board similar to MPC8272ADS board... 

1) For the first time it boots up properly in case if we overwrite any
existing binaries using nfs mounted file system on the board, after
rebooting it displays fallowing message... 

Further such events for this erase block will not be printed 
Eep. Child "null" (ino #1346) of dir ino #3 doesn't exist! 
Eep. Child "autocomm" (ino #463) of dir ino #461 doesn't exist! 
Eep. Child "calibration" (ino #464) of dir ino #461 doesn't exist! 
Eep. Child "coredsp_driver.ko" (ino #939) of dir ino #336 doesn't exist! 
Inode #1307 was a directory with children - removing those too... 
Inode #564 was a directory with children - removing those too... 
Inode #565 was a directory with children - removing those too... 
Inode #1112 was a directory with children - removing those too... 
Inode #1115 was a directory with children - removing those too... 
Inode #1118 was a directory with children - removing those too... 
Inode #1123 was a directory with children - removing those too... 

after this board boots up properly....but it not be having overwritten files 

2) while booting up for the first time itself it will display the falowing
message.. 

modprobe: FATAL: Could not load
/lib/modules/2.6.10_mvl401-8272ads/modules.dep: No such file or dire 
ctory 

but after this also board boots up properly 

3) when board is running properly in between it starts printing on console
repeatedly... 

Header CRC failed on REF_PRISTINE node at 0x00638a6c: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x00000254) 
Header CRC failed on REF_PRISTINE node at 0x00638cc0: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x00000234) 
Header CRC failed on REF_PRISTINE node at 0x00638ef4: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002c4) 
Header CRC failed on REF_PRISTINE node at 0x006391b8: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002b4) 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002c0) 
Header CRC failed on REF_PRISTINE node at 0x0063972c: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002bc) 
Header CRC failed on REF_PRISTINE node at 0x006399e8: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002ac) 
Header CRC failed on REF_PRISTINE node at 0x00639c94: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002b0) 
Header CRC failed on REF_PRISTINE node at 0x00639f44: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002ac) 
Header CRC failed on REF_PRISTINE node at 0x0063a1f0: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002c0) 
Header CRC failed on REF_PRISTINE node at 0x0063a4b0: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002b0) 
Header CRC failed on REF_PRISTINE node at 0x0063a760: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002b0) 
Header CRC failed on REF_PRISTINE node at 0x0063aa10: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002c8) 
Header CRC failed on REF_PRISTINE node at 0x0063acd8: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002b0) 
Header CRC failed on REF_PRISTINE node at 0x0063af88: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002c4) 
Header CRC failed on REF_PRISTINE node at 0x0063b24c: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002b4) 
Header CRC failed on REF_PRISTINE node at 0x0063b500: Read 0xffffffff,
calculated 0x44660075 
Node totlen on flash (0xffffffff) != totlen from node ref (0x000002c8) 
Header CRC failed on REF_PRISTINE node at 0x0063b7c8: Read 0xffffffff,
calculated 0x44660075 

are they debug messages or warnings...? 

do they create more problem or can i neglet these errors.. 

plz reply..it is too urgent 


here is my kerenl configurations.... 
# 
# Memory Technology Devices (MTD) 
# 
CONFIG_MTD=y 
# CONFIG_MTD_DEBUG is not set 
# CONFIG_MTD_CONCAT is not set 
CONFIG_MTD_PARTITIONS=y 
# CONFIG_MTD_REDBOOT_PARTS is not set 
CONFIG_MTD_CMDLINE_PARTS=y 

# 
# User Modules And Translation Layers 
# 
CONFIG_MTD_CHAR=y 
CONFIG_MTD_BLOCK=y 
# CONFIG_FTL is not set 
# CONFIG_NFTL is not set 
# CONFIG_INFTL is not set 
# CONFIG_RFD_FTL is not set 

# 
# RAM/ROM/Flash chip drivers 
# 
CONFIG_MTD_CFI=y 
CONFIG_MTD_JEDECPROBE=y 
CONFIG_MTD_GEN_PROBE=y 
CONFIG_MTD_CFI_ADV_OPTIONS=y 
CONFIG_MTD_CFI_NOSWAP=y 
# CONFIG_MTD_CFI_BE_BYTE_SWAP is not set 
# CONFIG_MTD_CFI_LE_BYTE_SWAP is not set 
CONFIG_MTD_CFI_GEOMETRY=y 
# CONFIG_MTD_MAP_BANK_WIDTH_1 is not set 
# CONFIG_MTD_MAP_BANK_WIDTH_2 is not set 
CONFIG_MTD_MAP_BANK_WIDTH_4=y 
# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set 
# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set 
# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set 
# CONFIG_MTD_CFI_I1 is not set 
CONFIG_MTD_CFI_I2=y 
# CONFIG_MTD_CFI_I4 is not set 
# CONFIG_MTD_CFI_I8 is not set 
# CONFIG_MTD_OTP is not set 
# CONFIG_MTD_CFI_INTELEXT is not set 
CONFIG_MTD_CFI_AMDSTD=y 
CONFIG_MTD_CFI_AMDSTD_RETRY=0 
# CONFIG_MTD_CFI_STAA is not set 
CONFIG_MTD_CFI_UTIL=y 
# CONFIG_MTD_RAM is not set 
CONFIG_MTD_ROM=y 
# CONFIG_MTD_ABSENT is not set 
# CONFIG_MTD_XIP is not set 

# 
# Mapping drivers for chip access 
# 
# CONFIG_MTD_COMPLEX_MAPPINGS is not set 
CONFIG_MTD_PHYSMAP=y 
CONFIG_MTD_PHYSMAP_START=0xFC000000 
CONFIG_MTD_PHYSMAP_LEN=0x4000000CONFIG_MTD_PHYSMAP_BANKWIDTH=4 
# CONFIG_MTD_MULTI_PHYSMAP is not set 
# CONFIG_MTD_SBC8240 is not set 
CONFIG_MTD_PQ2FADS=y 
# CONFIG_MTD_PLATRAM is not set 

CONFIG_JFFS2_FS=y 
CONFIG_JFFS2_FS_DEBUG=0 
CONFIG_JFFS2_FS_WRITEBUFFER=y 

 and 

file system is created using fallowing command.. 

mkfs.jffs2 -r RFS_NEW/ -e 0x20000 -o /tftpboot/jffs2_img -b 

do we need padding or not..? 



thnks in advance.. 

Nethra 




-- 
View this message in context: http://www.nabble.com/jffs2-file-system-on-MPC8272ADS-tf4513571.html#a12873633
Sent from the linuxppc-embedded mailing list archive at Nabble.com.
