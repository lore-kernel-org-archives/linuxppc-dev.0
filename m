Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id 56EA767A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Apr 2005 18:50:18 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Date: Thu, 21 Apr 2005 14:15:33 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED1027753@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: "Sam Song" <samlinuxppc@yahoo.com.cn>, <kishorekrd@gmail.com>
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

I forgot to mention this...u should do a soft reset. If you go about =
powering off and on your board your buffer will be flushed. But for a =
soft reset the contents will be retained.

-----Original Message-----
From: Sam Song [mailto:samlinuxppc@yahoo.com.cn]=20
Sent: Thursday, April 21, 2005 12:49 PM
To: Atit_Shah; kishorekrd@gmail.com
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8245 custom board, Linux 2.4 kernel hangs after =
uncompressing=20

Atit_Shah <Atit_Shah@satyam.com> wrote=A3=BA
> 1. Check your log buffer...your console may not be
> initialized yet so all your printk are logged at a=20
> particular memory location. Checkout the
> System.map file in the Linux folder for "log_buf".
> The address that you have there subtract it with=20
> the kernel base address. Then in view your
> memory at that location. We used U-Boot so we gave
> the command
> =09
> 	md <log_buff address>

Interesting to me as well. I also have such a similar
problem. But I wanna to know how I can return to=20
u-boot with software workaround after kernel hanging.
At least, I must power-off and power-on my target to
get back to u-boot console. If so, the last kernel=20
printk message would lost IMHO.

Thanks,

Sam

P.S. Atit_Shah, if possibel, pls set your subscribing
setting  "...daily digest" as "no" to avoid reply
inconvenience on the title:)

_________________________________________________________
Do You Yahoo!?
150=CD=F2=C7=FAMP3=B7=E8=BF=F1=CB=D1=A3=AC=B4=F8=C4=FA=B4=B3=C8=EB=D2=F4=C0=
=D6=B5=EE=CC=C3
http://music.yisou.com/
=C3=C0=C5=AE=C3=F7=D0=C7=D3=A6=D3=D0=BE=A1=D3=D0=A3=AC=CB=D1=B1=E9=C3=C0=CD=
=BC=A1=A2=D1=DE=CD=BC=BA=CD=BF=E1=CD=BC
http://image.yisou.com
1G=BE=CD=CA=C71000=D5=D7=A3=AC=D1=C5=BB=A2=B5=E7=D3=CA=D7=D4=D6=FA=C0=A9=C8=
=DD=A3=A1
http://cn.rd.yahoo.com/mail_cn/tag/1g/*http://cn.mail.yahoo.com/event/mai=
l_1g/


DISCLAIMER:
This email (including any attachments) is intended for the sole use of =
the intended recipient/s and may contain material that is CONFIDENTIAL =
AND PRIVATE COMPANY INFORMATION. Any review or reliance by others or =
copying or distribution or forwarding of any or all of the contents in =
this message is STRICTLY PROHIBITED. If you are not the intended =
recipient, please contact the sender by email and delete all copies; =
your cooperation in this regard is appreciated.
