Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15808.mail.cnb.yahoo.com (web15808.mail.cnb.yahoo.com
	[202.165.102.88]) by ozlabs.org (Postfix) with SMTP id B484A688DB
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 28 Dec 2005 21:20:33 +1100 (EST)
Message-ID: <20051228102029.26119.qmail@web15808.mail.cnb.yahoo.com>
Date: Wed, 28 Dec 2005 18:20:29 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: srideep.devireddy@wipro.com
In-Reply-To: <6AD9F6A5F6E096408F0B703773355A070E700C@CHN-SNR-MBX01.wipro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re : Linux kernel Hangs after transfer
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

--- srideep.devireddy@wipro.com wrote:
...
> log when i try to bootm 100000
> 
> 
> Bytes transferred = 644777 (9d6a9 hex)
> => bootm
> ## Booting image at 00100000 ...

Pls try 0x200000 to boot the image.
If didn't work, print the comandline
which was transfered to kernel.

Best regards,

Sam

__________________________________________________
∏œøÏ◊¢≤·—≈ª¢≥¨¥Û»›¡ø√‚∑—” œ‰?
http://cn.mail.yahoo.com
