Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15805.mail.cnb.yahoo.com (web15805.mail.cnb.yahoo.com
	[202.165.102.85]) by ozlabs.org (Postfix) with SMTP id F14D02BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Dec 2004 22:36:26 +1100 (EST)
Message-ID: <20041207113615.9141.qmail@web15805.mail.cnb.yahoo.com>
Date: Tue, 7 Dec 2004 19:36:15 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: What's the problem could be?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, all

An system application crash running on 2.4.18 was
happened on my custom 8xx board every now and then,
especially recently. Yeah, the probelm is becoming
more and more obvious. Personally, I deem it as an
default of application software because there are some
complicated application softwares like GUI and a
browser. But I also suspect that my custom keyboard
did it because there were about 70-80 PCMCIA
interrupts created once I hit just one key. I used
PCMCIA interrupt to accept the rubber keyboard input.
Still one thing, for development convenience, I just
use one SDRAM init setting and process for bus freq.
at 24MHZ/48MHZ. Which one could be the killer? Any
other possibility?

Thanks in advance!

=====
Best regards,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
