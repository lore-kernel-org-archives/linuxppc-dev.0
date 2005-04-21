Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15803.mail.cnb.yahoo.com (web15803.mail.cnb.yahoo.com
	[202.165.102.83]) by ozlabs.org (Postfix) with SMTP id A0CF467A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 20:03:05 +1000 (EST)
Message-ID: <20050421100303.82254.qmail@web15803.mail.cnb.yahoo.com>
Date: Thu, 21 Apr 2005 18:03:03 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC8245 custom board, Linux 2.4 kernel hangs after uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Eugene Surovegin <ebs@ebshome.net> wrote:
> On Thu, Apr 21, 2005 at 03:19:10PM +0800, Sam Song
> wrote:
> > Interesting to me as well. I also have such a
> > similar problem. But I wanna to know how I can 
> > return to u-boot with software workaround after 
> > kernel hanging.
>
> Easy, use BDI (or any other hw debugger) and reset
> target when it hangs.

Thanks, Eugene. This one should work. It seems that 
I must use a HW tool to deal with my trouble.

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
