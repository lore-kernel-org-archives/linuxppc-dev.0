Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15810.mail.cnb.yahoo.com (web15810.mail.cnb.yahoo.com
	[202.165.102.90]) by ozlabs.org (Postfix) with SMTP id D987367A6B
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 23 Apr 2005 22:16:47 +1000 (EST)
Message-ID: <20050423121645.63553.qmail@web15810.mail.cnb.yahoo.com>
Date: Sat, 23 Apr 2005 20:16:45 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: "Mark A. Greer" <mgreer@mvista.com>
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
> >had, is it possible to flush the content of 
__log_buf
> >after reset?
>
> Sam,
> 
> I thought I finally noticed yesterday that you're
> using 2.4. If that is
> the case, you want to dump "log_buf" not
> "__log_buf".

Uh, I copy the above note to this thread to
continue:-)

The turth is that I ported denx 2.4.24 successfully on
my board
 and try to port it to 2.6.x.  To my understanding,
UART init was
bad for some reason. It was auto configured as 16450
rather than 
16550A as 2.4.  Besides, ttyS0 iomem base address in
2.6 is different
to the one in 2.4 although they have the same serial
address setting.
I wander which kind of possiblity coud lead to this
result or even better
to point out some useful printk locations to me. 

If possible, could you pls show me a right 2.6 boot
process of
 sandpoint X3/2? I wanna to find out some nice hints
of it. This
is the first time to me so hard to debug a kernel
before normal 
console. 

Thanks a lot,

Sam  

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
