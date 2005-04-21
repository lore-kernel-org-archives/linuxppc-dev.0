Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15805.mail.cnb.yahoo.com (web15805.mail.cnb.yahoo.com
	[202.165.102.85]) by ozlabs.org (Postfix) with SMTP id B1E6867A6B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 12:40:10 +1000 (EST)
Message-ID: <20050421024005.32847.qmail@web15805.mail.cnb.yahoo.com>
Date: Thu, 21 Apr 2005 10:40:05 +0800 (CST)
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

"Mark A. Greer" <mgreer@mvista.com> wrote:
> > I cannot see any active info.Is early console
> > output message not enough to find out something 
> > useful? 
>
> Sure it does. You have to enable it, then add some
> progress lines to help narrow down where you're
> panic'ing/hanging. 

Well, the cmdline I added is the switch of early
console enable, which I should enable 
CONFIG_SERIAL_8250_CONSOLE in kernel config first. A
new and nice feature of 2.6.x to me.

> You can even use the
> progress facility to dump the __log_buf.

I don't have such experience. If possible, could u
give me a linkage or doc for me to have a look?

> I'm taking your unwillingness to use a jtag/cops
> debugger as indication
> that you don't have such a tool!?!?

For the moment, I don't have such a cute hardware 
tool which can support source code debug like 
BDI2000. To be frank, I haven't used a hardware tool 
to debug kernel. Perhaps the problem I met wasn't 
complicated to use it. But now it is another story:-)
BTW, Could I use KGDB to try it?

Thanks,

Sam

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
