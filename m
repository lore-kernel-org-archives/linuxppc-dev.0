Return-Path: <samlinuxppc@yahoo.com.cn>
Received: from web15801.mail.cnb.yahoo.com (web15801.mail.cnb.yahoo.com
	[202.165.102.81]) by ozlabs.org (Postfix) with SMTP id 22BAD67A6C
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 19:58:51 +1000 (EST)
Message-ID: <20050421095849.66260.qmail@web15801.mail.cnb.yahoo.com>
Date: Thu, 21 Apr 2005 17:58:49 +0800 (CST)
From: Sam Song <samlinuxppc@yahoo.com.cn>
To: Atit_Shah <Atit_Shah@satyam.com>, kishorekrd@gmail.com
In-Reply-To: 6667
MIME-Version: 1.0
Content-Type: text/plain; charset=gb2312
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8245 custom board,
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

--- Atit_Shah <Atit_Shah@satyam.com> wrote:
> I forgot to mention this...u should do a soft reset.
> If you go about powering off and on your board your
> buffer will be flushed. But for a soft reset the
> contents will be retained.

Ummm, in my experience, if kernel hangs, either it
could reboot automatically or it will stop there 
and doesn't respone any input from serial console. My
situation is the second. So soft reset couldn't work
at all:)

Thanks,

Sam


_________________________________________________________
Do You Yahoo!?
注册世界一流品质的雅虎免费电邮
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/
