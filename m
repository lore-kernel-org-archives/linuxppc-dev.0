Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15802.mail.cnb.yahoo.com (web15802.mail.cnb.yahoo.com
	[202.165.102.82]) by ozlabs.org (Postfix) with SMTP id 4617E679F1
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 May 2005 22:59:38 +1000 (EST)
Message-ID: <20050516125932.71078.qmail@web15802.mail.cnb.yahoo.com>
Date: Mon, 16 May 2005 20:59:31 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: 'linuxppc-embedded maillist' <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Subject: 2.6.x insmod problem on 82xx platform
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

I met a strange problem when trying to insmod a 
extern module in 2.6.12-rc2 on a MPC8241 board.
Even lsmod didn't work. Following is the error
message working on ELDK3.0. 

bash-2.05b# insmod mymodule.o
insmod: QM_MODULES: Function not implemented

bash-2.05b# lsmod
Module                  Size  Used by
lsmod: QM_MODULES: Function not implemented

I greped QM_MODULES in the kernel source code
but found nothing. What's happening to LKM in
2.6.x? 

Don't tell me that LKM hasn't been supported
yet in 2.6.x:-)

Thanks in advance,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
