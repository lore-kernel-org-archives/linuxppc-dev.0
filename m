Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id F18A1DDEA0
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Feb 2007 01:55:17 +1100 (EST)
Message-ID: <45D5C5CC.9070406@ru.mvista.com>
Date: Fri, 16 Feb 2007 17:55:08 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>
Subject: Re: [PATCH] use winbond libata instead of ide driver for pseries
	CD drives
References: <20070210203512.GA25586@aepfle.de>
	<20070216092046.GA2572@aepfle.de> <45D5B720.4010308@ru.mvista.com>
	<200702161553.54550.bzolnier@gmail.com>
In-Reply-To: <200702161553.54550.bzolnier@gmail.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>,
	Jeff Garzik <jeff@garzik.org>, linux-ide@vger.kernel.org,
	linuxppc-dev@ozlabs.org, Paul Mackeras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Bartlomiej Zolnierkiewicz wrote:

>>    I'm sorry, how those 2 drivers can be equivalent?! The pata_winbond driver 
>>is for VLB only, sl81c105 was for PCI only -- you certainly want to use 
>>pata_sl82c105 (indeed better version of sl82c105 driver).

> I was under the impression that with your fixes these drivers
> (sl82c105 and pata_sl82c105) are functionally equivalent.

    They're not yet equivalent. pata_sl82c105 supports all MWDMA modes, 
sl82c105 still supports only MWDMA2.

WBR, Sergei
