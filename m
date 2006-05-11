Return-Path: <x.xiao@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id DBDEC679F9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 12 May 2006 00:08:07 +1000 (EST)
Message-ID: <44634541.3040109@freescale.com>
Date: Thu, 11 May 2006 09:08:01 -0500
From: Xianghua Xiao <x.xiao@freescale.com>
MIME-Version: 1.0
To: Sam Song <samlinuxppc@yahoo.com.cn>
Subject: Re: MPC8641(D) software status
References: <20060511135328.25523.qmail@web15706.mail.cnb.yahoo.com>
In-Reply-To: <20060511135328.25523.qmail@web15706.mail.cnb.yahoo.com>
Content-Type: text/plain; charset=GB2312
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Sam,

We have patches for 8641D against 2.6.15/2.6.16 and it works well in lab
in the last three months along with u-boot code. I think a patch against
2.6.17 or later will be released in the future. However if you need the
2.6.15/2.6.16 patch now, you can contact Freescale directly. In fact,
for all 8641D boards we will ship, we will include the kernel/u-boot
source code on the SATA hard drive directly as well, or you can also
download them from freescale's website.

Hope this helps,
Xianghua


Sam Song wrote:

>Dear all,
>
>Could anyone kindly disclose any info on
>its boot code and kernel support?
>
>Mass production is under way if I am not 
>wrong but less info on software. Just out of
>interest to know that... Maybe I could have 
>the luck to touch it.
>
>Thanks in advance,
>
>Sam
>
>
>	
>
>	
>		
>___________________________________________________________ 
>ÑÅ»¢Ãâ·ÑÓÊÏä-3.5GÈÝÁ¿£¬20M¸½¼þ
>http://cn.mail.yahoo.com/
>_______________________________________________
>Linuxppc-embedded mailing list
>Linuxppc-embedded@ozlabs.org
>https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
