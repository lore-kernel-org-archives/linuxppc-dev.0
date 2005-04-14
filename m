Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15807.mail.cnb.yahoo.com (web15807.mail.cnb.yahoo.com
	[202.165.102.87]) by ozlabs.org (Postfix) with SMTP id BF54667B67
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Apr 2005 15:01:07 +1000 (EST)
Message-ID: <20050414050104.51491.qmail@web15807.mail.cnb.yahoo.com>
Date: Thu, 14 Apr 2005 13:01:04 +0800 (CST)
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

--- "Mark A. Greer" <mgreer@mvista.com> wrote:
[snip]
> No problem, Sam. Let me know if you encounter any
> problems with it.

Well, encounter one puzzle on bd_info:-)

I use 2.6.11 release package on my custom Sandpoint
board with u-boot. In 2.6.11 ppcboot.h, I noticed 
that there were no CONFIG_8260 but CONFIG_CPM2, 
which had a conflict with bd_info of u-boot. Does
CONFIG_CPM2 means CONFIG_8260 in 2.6.x? If so, it
seems that I should use CPM2 UART driver rather 
than the one CONFIG_SERIAL_8250 which is defined by
sandpoint_defconfig. Well, CPM2 UART driver support
is off line from menuconfig:-(

I created one image only with 8250 serial and RAMDISK
support kernel. The console setting is "ttyS0,115200".
But hanged after loading the kernel... What could the
problem be?

Thanks for your kind help,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
