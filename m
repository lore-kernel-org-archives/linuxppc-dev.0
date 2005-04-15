Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15806.mail.cnb.yahoo.com (web15806.mail.cnb.yahoo.com
	[202.165.102.86]) by ozlabs.org (Postfix) with SMTP id 638C467B1B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 15 Apr 2005 12:24:33 +1000 (EST)
Message-ID: <20050415022430.52080.qmail@web15806.mail.cnb.yahoo.com>
Date: Fri, 15 Apr 2005 10:24:30 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x Sandpoint with 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com>

Re: 824x Sandpoint with 2.6.x


--- Sam Song <samlinuxppc@yahoo.com.cn> wrote:
[snip]
> which had a conflict with bd_info of u-boot. Does
> CONFIG_CPM2 means CONFIG_8260 in 2.6.x? If so, it
> seems that I should use CPM2 UART driver rather 
> than the one CONFIG_SERIAL_8250 which is defined by
> sandpoint_defconfig. Well, CPM2 UART driver support
> is off line from menuconfig:-(

I got the answer after a glance at the Manual itself.
824x is so different to 8260/8270. No CPM at all on
it. The DUART's program model is compatible with 
16550. Also no IMMR value... I thought 824x could have
a model as 8260 or even 8xx. New things learned!

> I created one image only with 8250 serial and
> RAMDISK support kernel. The console setting was
> "ttyS0,115200". But hanged after loading the 
> kernel... What could the problem be?

Still no luck. From the print message I set, it passed
MMU_init() and mpc10x_bridge_init(), then stopped.

Any clue on it? 

Thanks,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
