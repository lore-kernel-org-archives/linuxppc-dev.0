Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9C10DDDDFD
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 21:46:47 +1000 (EST)
Message-ID: <4704D263.9010404@ru.mvista.com>
Date: Thu, 04 Oct 2007 15:45:39 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: jxnuxdy <jxnuxdy@163.com>
Subject: Re: linux ethernet problem
References: <9e4733910710031633v3bb409c9j32b345e12396c1b0@mail.gmail.com>	<OFFFD4BE8F.17F6E427-ON88257369.006D8651-88257369.00736D96@selinc.com>	<OF5A3A8901.AAC62E29-ON88257369.007F3E0B-88257369.007FC5D0@selinc.com>
	<4418074.198781191459542009.JavaMail.coremail@bj163app58.163.com>
In-Reply-To: <4418074.198781191459542009.JavaMail.coremail@bj163app58.163.com>
Content-Type: text/plain; charset=x-gbk; format=flowed
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

jxnuxdy wrote:
> Hi,
>  
>    I use the 440epx CPU and bcm5241 PHY in my system, the ehternet works 
> fine in u-boot, however I can't use the ethernet in linux if I didn't 
> active the ehernet in u-boot(such as 'ping'... or 'tftp'...).
>  
>    Is there anyone even encounter such problem? is the issue due to my 
> u-boot or linux?

What kernel version do you use?
Please, make sure that phy is initialized by linux and the phy mode is 
correct.
IIRC, bcm5241 is connected to the ZMII bridge and works in SMII mode.
Thanks,
Valentine.

>  
>  
> ,Regards
> - Denny
> 
> 
> 网 易 Yeah.net 免 费 邮 箱 全 新 改 版，珍 藏 帐 号 开 放，快 来 抢 注 
>  >> < http://event.mail.163.com/chanel/click.htm?from=NO_16&domain=163>
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
