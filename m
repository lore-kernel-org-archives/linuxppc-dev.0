Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15804.mail.cnb.yahoo.com (web15804.mail.cnb.yahoo.com
	[202.165.102.84]) by ozlabs.org (Postfix) with SMTP id 699412BF0E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Dec 2004 21:32:16 +1100 (EST)
Message-ID: <20041217103214.33716.qmail@web15804.mail.cnb.yahoo.com>
Date: Fri, 17 Dec 2004 18:32:14 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6473AA@whq-msgusr-02.pit.comms.marconi.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: Re: Error cross-building  Linux 2.6 for 8xx
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

"Povolotsky, Alexander"
Alexander.Povolotsky@marconi.com> wrote：
> Hi - I am double posting this on both:
> linuxppc-embedded@ozlabs.org and
> etux@embeddedtux.org, hoping to increase the 
> audience and, hence, to maximize the
> number of responses (if

Pls try to avoid cross-posting your technical message.


> Then I took the I2C configuration out and tried to
> build the kernel again -
> but I am still getting errors
> (not sure though whether cross-compiler
> "contributes" to those recent errors
> or not ... - I would, as always,
> appreciate any opinion/input ! ):

To get a workable 2.6.x 8xx kernel running with
ramdisk root filesystem, you could refer to:

http://ozlabs.org/pipermail/linuxppc-dev/2004-September/017602.html

And also from this thread, you could get a clear clue
on the 2.6 porting on 8xx.

I tested 2.6 kernel on RPXlite DW from 2.6.7 to
2.6.9-rc2 with ELDK3.0. All worked fine with ramdisk.
If adding the ONE-LINE patch from Pantelis Antoniou
which you could get it on the thread, it could work
right with NFS but still need some fix to make it on
production.

It seems that we leave the right result just one step
but it's most likely the most difficult part, IMHO:-)


 

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
