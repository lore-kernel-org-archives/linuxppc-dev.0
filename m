Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [64.81.67.12])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 336D767A33
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 01:47:39 +1000 (EST)
Date: Thu, 21 Apr 2005 08:47:34 -0700
From: Eugene Surovegin <ebs@ebshome.net>
To: Marco Schramel <Schramel.Linux@go.bartec.de>
Message-ID: <20050421154733.GC8189@gate.ebshome.net>
References: <200504211117.25584.Schramel.Linux@go.bartec.de>
	<20050421085037.GB8189@gate.ebshome.net>
	<200504211144.28584.Schramel.Linux@go.bartec.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200504211144.28584.Schramel.Linux@go.bartec.de>
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

On Thu, Apr 21, 2005 at 11:44:28AM +0200, Marco Schramel wrote:
> Hi Eugene,
> 
> thanks for your answer
> 
> > Check that you have CONFIG_MTD_BLOCK enabled in your .config. 
> #
> # Memory Technology Devices (MTD)
> #
> CONFIG_MTD=y
> CONFIG_MTD_DEBUG=y
> CONFIG_MTD_DEBUG_VERBOSE=0
> CONFIG_MTD_PARTITIONS=y
> # CONFIG_MTD_CONCAT is not set
> # CONFIG_MTD_REDBOOT_PARTS is not set
> # CONFIG_MTD_CMDLINE_PARTS is not set
> CONFIG_MTD_CHAR=y
> CONFIG_MTD_BLOCK=y
> # CONFIG_FTL is not set
> # CONFIG_NFTL is not set
> # CONFIG_INFTL is not set
> 
> > 
> > Also, check that you have /dev/mtdblock1 node in /dev directory on the 
> > target.
> >
> 
> This is what i meant before with ramdisk. 
> 
> /dev # ls -al mtdblock1
> brw-rw-r--    1 root     root      31,   1 Mar 17  2005 mtdblock1
> 
> It should be ok. Isn't it ??

Hmm, yes, provided you have also jffs2 enabled, but I'd expect 
different error message if not.

Could you show us dmesg output, and also `cat /proc/devices`?

-- 
Eugene
