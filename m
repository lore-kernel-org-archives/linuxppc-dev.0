Return-Path: <Schramel.Linux@go.bartec.de>
Received: from mail.bartec.de (mail.bartec.de [217.5.168.170])
	by ozlabs.org (Postfix) with SMTP id D809A67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 19:10:56 +1000 (EST)
From: Marco Schramel <Schramel.Linux@go.bartec.de>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Thu, 21 Apr 2005 11:44:28 +0200
References: <200504211117.25584.Schramel.Linux@go.bartec.de>
	<20050421085037.GB8189@gate.ebshome.net>
In-Reply-To: <20050421085037.GB8189@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200504211144.28584.Schramel.Linux@go.bartec.de>
Cc: PPC_LINUX <linuxppc-embedded@ozlabs.org>
Subject: Re: mtd mount problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Eugene,

thanks for your answer

> Check that you have CONFIG_MTD_BLOCK enabled in your .config. 
#
# Memory Technology Devices (MTD)
#
CONFIG_MTD=y
CONFIG_MTD_DEBUG=y
CONFIG_MTD_DEBUG_VERBOSE=0
CONFIG_MTD_PARTITIONS=y
# CONFIG_MTD_CONCAT is not set
# CONFIG_MTD_REDBOOT_PARTS is not set
# CONFIG_MTD_CMDLINE_PARTS is not set
CONFIG_MTD_CHAR=y
CONFIG_MTD_BLOCK=y
# CONFIG_FTL is not set
# CONFIG_NFTL is not set
# CONFIG_INFTL is not set

> 
> Also, check that you have /dev/mtdblock1 node in /dev directory on the 
> target.
>

This is what i meant before with ramdisk. 

/dev # ls -al mtdblock1
brw-rw-r--    1 root     root      31,   1 Mar 17  2005 mtdblock1

It should be ok. Isn't it ??

Thanks
Marco



-- 
---------
Marco Schramel
