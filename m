Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15803.mail.cnb.yahoo.com (web15803.mail.cnb.yahoo.com
	[202.165.102.83]) by ozlabs.org (Postfix) with SMTP id 93BE867A67
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 12:30:24 +1000 (EST)
Message-ID: <20050422023020.98562.qmail@web15803.mail.cnb.yahoo.com>
Date: Fri, 22 Apr 2005 10:30:20 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 custom board,
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

Wolfgang Denk <wd@denx.de> wrote:
> > Interesting to me as well. I also have such a
> > similar problem. But I wanna to know how I can 
> > return to u-boot with software workaround after 
> > kernel hanging.
> 
> Press the reset button?
> 

The pity is that hardware reset doesn't work on my
board. Sadly... Well, just to confirm this case. If
had, is it possible to flush the content of __log_buf
after reset?

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
