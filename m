Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15608.mail.cnb.yahoo.com (web15608.mail.cnb.yahoo.com
	[202.165.102.62]) by ozlabs.org (Postfix) with SMTP id 732002BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 11 Nov 2004 18:22:58 +1100 (EST)
Message-ID: <20041111072256.26845.qmail@web15608.mail.cnb.yahoo.com>
Date: Thu, 11 Nov 2004 15:22:56 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: linuxppc-embedded@ozlabs.org
In-Reply-To: <4191694C.60305@esteem.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: Re: How much easier makes owning a BDI2000 things?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Conn Clark <clark@esteem.com> wrote:
> Wolfgang Denk wrote:
[snip]
> > Seems you never had to deal with any time critical
> > problems, then.
> > 
> 
> I have, however I used I/O bits and an Oscilliscope
> ;-)

But how about the time you solved the problem? Suppose
a sudden power failure happened and the monitor port
of your custom board couldn't give any output. Could
you find the problem in no time like 5 - 10 minutes at
most? I met this problem twice on my custom board. It
took me one night to find out the problem at first
under help of BDI2000 and Oscilliscope without any
experience. The problem was SDRAM damage. And BDI2000
helped me make sure that 4 SDRAM chips on board were
all broken. Second time, I just found out the real
problem in 10 minutes or so with BDI2000. There were 2
broken of 4 parallel FLASH chips in 8-bit. 

So, IMHO, for the sake of efficiency and accurateness,
BDI2000 is much better than Oscilliscope, at least in
time critical situation like trouble shooting.

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
