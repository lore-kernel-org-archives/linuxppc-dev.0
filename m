Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15601.mail.cnb.yahoo.com (web15601.mail.cnb.yahoo.com
	[202.165.102.55]) by ozlabs.org (Postfix) with SMTP id 95BD62BDA0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 19:27:42 +1000 (EST)
Message-ID: <20041014092739.6826.qmail@web15601.mail.cnb.yahoo.com>
Date: Thu, 14 Oct 2004 17:27:39 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Marius Groeger <mgroeger@sysgo.com>
In-Reply-To: <Pine.LNX.4.61.0410140952570.1661@mag.sysgo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Meaning of BSP and LSP
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Marius Groeger <mgroeger@sysgo.com> wrote：

> From what I know, the term BSP was coined as an
> acronym for "Board Support Package" in pre-Linux 
> days. To me it is most familiar in 

So that day the meaning of BSP was clear enough.

> "LSP" is a term introduced by MontaVista, AFAIR, so
> maybe one of the MV folks on this list wants to 
> elaborate on this?

I also got the term "LSP" from MV. 
 
> Bottom line: BSP is an OS/Vendor specific term to
> capture the software components related to a 
> specific board. It is a useful handle in 
> project discussions, provided that all participants
> use the same notion.

See what's EP view on "BSP". 
http://www.embeddedplanet.com/products/bsp_linux.asp

It seems that BSP > = LSP.

Just as Wolfgang said, the meaning  varys in different
vendors. But at least "LSP" by MV doesn't include
hardware scheme and boot loader code, I think.

"LSP" is a special term defined by MV. So just to
follow the meaning as MV does.

Thanks for your nice comment on this topic.

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
