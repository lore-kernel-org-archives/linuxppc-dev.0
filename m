Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15609.mail.cnb.yahoo.com (web15609.mail.cnb.yahoo.com
	[202.165.102.63]) by ozlabs.org (Postfix) with SMTP id 59E772BD9F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 12 Oct 2004 11:12:55 +1000 (EST)
Message-ID: <20041012011250.37596.qmail@web15609.mail.cnb.yahoo.com>
Date: Tue, 12 Oct 2004 09:12:50 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: annamaya <annamaya@yahoo.com>,
	Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041012003339.B1EB92BDDA@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Booting Linux using a PlanetCore BootLoader 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

annamaya <annamaya@yahoo.com> wrote:
> now able to see the "relocation" messages by zImage
> and it now halts with the message "Now booting the
> kernel". I see that it is now hung in some delay
[snip]
> Linux/PPC load: root=/dev/nfs rw ip=on

Well, I guess there is sth wrong in your parameter
passing to kernel. Add "Console=ttyS0,9600" in it and
try. 




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
