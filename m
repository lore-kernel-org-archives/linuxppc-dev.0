Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15601.mail.cnb.yahoo.com (web15601.mail.cnb.yahoo.com
	[202.165.102.55]) by ozlabs.org (Postfix) with SMTP id 931562BC0F
	for <linuxppc-dev@ozlabs.org>; Mon, 20 Sep 2004 21:47:34 +1000 (EST)
Message-ID: <20040920114723.35233.qmail@web15601.mail.cnb.yahoo.com>
Date: Mon, 20 Sep 2004 19:47:23 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
To: Pantelis Antoniou <panto@intracom.gr>
In-Reply-To: <414E7265.4090105@intracom.gr>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-dev@ozlabs.org
Subject: Re: Linux 2.6.x on 8xx status
List-Id: "Linux on PowerPC \(Including Embedded\) Developers Mail List"
	<linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Pantelis Antoniou <panto@intracom.gr> wrote：
> Ahem, the new ethernet driver is for the FEC not the
> SCC.

Oh, I misused the driver but got the improvement. A
little strange...

> By the bootload messages RPXlite uses the SCC
> ethernet.

Yeah, RPXlite uses SCC2 as Ethernet Controller.

Thanks for pointing out the key problem.

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
