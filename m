Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5814A2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Nov 2004 06:45:14 +1100 (EST)
In-Reply-To: <20041114092806.76018.qmail@web15603.mail.cnb.yahoo.com>
References: <20041114092806.76018.qmail@web15603.mail.cnb.yahoo.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <38FB8908-373F-11D9-A70B-003065F9B7DC@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Mon, 15 Nov 2004 14:47:46 -0500
To: Sam Song <samlinuxppc@yahoo.com.cn>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Any possibility of common mini test kernel for 8xx/82xx/85xx?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Nov 14, 2004, at 4:28 AM, Sam Song wrote:

> could I deduce a possibility that we can make a common
> mini test kerenl which only support
> Monitor/RAMDISK/EXT2 for 8xx/82xx/85xx? Or even better
> work on all PowerPC boards?

The Linux kernels are very different and would have to be
unique.  I have small ram disks for demos that I run
on all PowerPC platforms.


	-- Dan
