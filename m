Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15604.mail.cnb.yahoo.com (web15604.mail.cnb.yahoo.com
	[202.165.102.58]) by ozlabs.org (Postfix) with SMTP id 710B02BDCF
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Sep 2004 21:09:47 +1000 (EST)
Message-ID: <20040922110942.69741.qmail@web15604.mail.cnb.yahoo.com>
Date: Wed, 22 Sep 2004 19:09:42 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Dan Malek <dan@embeddededge.com>,
	"Smith, Craig" <craig.d.smith@siemens.com>
In-Reply-To: <28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
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

Dan Malek <dan@embeddededge.com> wrote：
> I suggested this change to a few people hoping the
> information would lead them to finding the real 
> problem, not that it should be perpetuated as 
> a "fix" to make 8xx work. I don't personally have 
> time to work on this right now,
> so anyone using 8xx should be looking for the real
> cause and solution, not using this to create
> products.

Thanks for this clarification. We were just having a
beta test on it. I also noticed that there were some
disorder characters in NFS init process. Not smooth as
2.4.x did. But it was a big advance to the real
problem, especially BDI2000 firware cannot function
well for 2.6.x debug ATM. If possible, I wanna to try
JFFS2 on it to see how faster JFFS2 of 2.6 in boot
time, which David Woodhouse suggested. All
experimental.

Thanks again,

Sam

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
