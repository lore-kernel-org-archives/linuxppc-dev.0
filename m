Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15808.mail.cnb.yahoo.com (web15808.mail.cnb.yahoo.com
	[202.165.102.88]) by ozlabs.org (Postfix) with SMTP id 3968B67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 17:19:12 +1000 (EST)
Message-ID: <20050421071910.46237.qmail@web15808.mail.cnb.yahoo.com>
Date: Thu, 21 Apr 2005 15:19:10 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Atit_Shah <Atit_Shah@satyam.com>, kishorekrd@gmail.com
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED1027752@bsdmsg002.corp.satyam.ad>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8245 custom board,
	Linux 2.4 kernel hangs after uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Atit_Shah <Atit_Shah@satyam.com> wrote：
> 1. Check your log buffer...your console may not be
> initialized yet so all your printk are logged at a 
> particular memory location. Checkout the
> System.map file in the Linux folder for "log_buf".
> The address that you have there subtract it with 
> the kernel base address. Then in view your
> memory at that location. We used U-Boot so we gave
> the command
> 	
> 	md <log_buff address>

Interesting to me as well. I also have such a similar
problem. But I wanna to know how I can return to 
u-boot with software workaround after kernel hanging.
At least, I must power-off and power-on my target to
get back to u-boot console. If so, the last kernel 
printk message would lost IMHO.

Thanks,

Sam

P.S. Atit_Shah, if possibel, pls set your subscribing
setting  "...daily digest" as "no" to avoid reply
inconvenience on the title:)

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
