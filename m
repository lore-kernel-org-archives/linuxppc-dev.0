Return-Path: <Murray.Jensen@csiro.au>
Received: from act-ironport-ext-out1.csiro.au (act-ironport-ext-out1.csiro.au
	[150.229.7.37]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "*.csiro.au",
	Issuer "Comodo Class 3 Security Services CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id D96B767FEA
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  1 Sep 2005 17:25:40 +1000 (EST)
From: Murray.Jensen@csiro.au
To: "Adrian B. Weissman" <aweissma_ppc@yahoo.com>
In-reply-to: Your message of "Wed, 31 Aug 2005 22:46:50 -0700"
	<20050901054650.11322.qmail@web35208.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 17:16:09 +1000
Message-ID: <3866.1125558969@gerd>
Sender: Murray.Jensen@csiro.au
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: A question regarding ramdisks 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 31 Aug 2005 22:46:50 -0700 (PDT), "Adrian B. Weissman" writes:
>     Here is what I am doing, I make uImage, after
>configuring ramdisk support
>
>CONFIG_BLK_DEV_RAM=y
>CONFIG_BLK_DEV_RAM_COUNT=2
>CONFIG_BLK_DEV_RAM_SIZE=4096
>CONFIG_INITRAMFS_SOURCE=""
>CONFIG_RAMFS=y

Do you have CONFIG_BLK_DEV_INITRD enabled? Cheers!
								Murray...
-- 
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

To the extent permitted by law, CSIRO does not represent, warrant and/or
guarantee that the integrity of this communication has been maintained or
that the communication is free of errors, virus, interception or interference.

The information contained in this e-mail may be confidential or privileged.
Any unauthorised use or disclosure is prohibited. If you have received this
e-mail in error, please delete it immediately and notify Murray Jensen on
+61 3 9662 7763. Thank you.
