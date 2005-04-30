Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15802.mail.cnb.yahoo.com (web15802.mail.cnb.yahoo.com
	[202.165.102.82]) by ozlabs.org (Postfix) with SMTP id 107A267A01
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Apr 2005 15:33:32 +1000 (EST)
Message-ID: <20050430053329.25386.qmail@web15802.mail.cnb.yahoo.com>
Date: Sat, 30 Apr 2005 13:33:29 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 824x sandpoint and 2.6.x
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Mark A. Greer" <mgreer@mvista.com> wrote:
[snip]
> Here is the output of a 7457 sandpoint on a very old
> root filesystem.
> Output for any other processor will be the same.

Thanks. Some useful hints inside.

[snip]
> ttyS0 at MMIO 0x0 (irq = 4) is a NS16550A

Mine is "ttyS0 at MMIO 0xfdfce500 (irq = 5) is a 
16450". Have some ideas to try but I am on vacation:)

> ttyS1 at MMIO 0x0 (irq = 3) is a NS16550A

I masked ttyS1 manually.

Thanks again,

Have a nice Labor Day:)

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
