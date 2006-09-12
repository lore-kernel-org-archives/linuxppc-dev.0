Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id E3CD4679E7
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Sep 2006 22:58:16 +1000 (EST)
Message-ID: <4506AF69.30905@ru.mvista.com>
Date: Tue, 12 Sep 2006 17:00:25 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Suzuki Takashi <setsu@emi.yamaha.co.jp>
Subject: Re: SM501 Kernel display driver for v2.6.17
References: <BDCC9646-9F98-4FFC-B0D8-A73E05B799A4@emi.yamaha.co.jp>
In-Reply-To: <BDCC9646-9F98-4FFC-B0D8-A73E05B799A4@emi.yamaha.co.jp>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Linux-MIPS <linux-mips@linux-mips.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello.

Suzuki Takashi wrote:
> I want to make Voyager GX PCI Demo Board Ver.A work on Yosemite board.

> I know Silicon Motion have Linux Kernel_v2.6 Display driver:
> http://www.siliconmotion.com.tw/en/en2/download2c.htm

> But it's for v2.6.4 and it cannot be compiled with v2.6.17 working on
> Yosemite board.

> Does anybody have succeeded in making the board work with v2.6.17?
> If there is a patch or source code available, let me know the location.

    I know that Linux/MIPS project maintains the framebuffer driver in 
drivers/video/smivgxfb.c. We used to backport it to 2.6.10 and it worked for 
us... Here's the link to the latest source:

http://www.linux-mips.org/git?p=linux.git;a=blob;h=c521069c905b4252109b8144478b4381c0ccdb7f;hb=db092db967ec0824db433c4adf3b58202fe610e2;f=drivers/video/smivgxfb.c

> Thanks in advance,

> -- T.Suzuki

WBR, Sergei
