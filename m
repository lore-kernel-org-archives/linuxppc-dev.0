Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15805.mail.cnb.yahoo.com (web15805.mail.cnb.yahoo.com
	[202.165.102.85]) by ozlabs.org (Postfix) with SMTP id 1C38267A64
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 15:35:31 +1000 (EST)
Message-ID: <20050422053530.43298.qmail@web15805.mail.cnb.yahoo.com>
Date: Fri, 22 Apr 2005 13:35:29 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Atit_Shah <Atit_Shah@satyam.com>, Kishore Devireddy <kishorekrd@gmail.com>
In-Reply-To: <D8595042F3765A4285B848A78A2C2ED1027757@bsdmsg002.corp.satyam.ad>
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8245 custom board, Linux 2.4 kernel hangs after uncompressing
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Atit_Shah <Atit_Shah@satyam.com> wrote：
> What we did was verified the value of PSDMR register
> value found in your board specific header file in
> include/configs/<boardname.h>

Ummm, PSDMR register is for 8260 perhaps? I even 
didn't find it in 8245UM. Do you mean MCCR of 8245?

Thanks,

Sam

_________________________________________________________
Do You Yahoo!?
150万曲MP3疯狂搜，带您闯入音乐殿堂
http://music.yisou.com/
美女明星应有尽有，搜遍美图、艳图和酷图
http://image.yisou.com
1G就是1000兆，雅虎电邮自助扩容！
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mail_1g/
