Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id 5F0BD67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 16:24:39 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="gb2312"
Date: Fri, 22 Apr 2005 11:50:35 +0530
Message-ID: <D8595042F3765A4285B848A78A2C2ED102775C@bsdmsg002.corp.satyam.ad>
From: "Atit_Shah" <Atit_Shah@satyam.com>
To: "Sam Song" <samlinuxppc@yahoo.com.cn>,
	"Kishore Devireddy" <kishorekrd@gmail.com>
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

All I know is PSDMR is for 8260 and it pertains to burst mode operation. =
I don=A1=AFt know MCCR :)


-----Original Message-----
From: Sam Song [mailto:samlinuxppc@yahoo.com.cn]=20
Sent: Friday, April 22, 2005 11:05 AM
To: Atit_Shah; Kishore Devireddy
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: MPC8245 custom board, Linux 2.4 kernel hangs after =
uncompressing

Atit_Shah <Atit_Shah@satyam.com> wrote=A3=BA
> What we did was verified the value of PSDMR register
> value found in your board specific header file in
> include/configs/<boardname.h>

Ummm, PSDMR register is for 8260 perhaps? I even=20
didn't find it in 8245UM. Do you mean MCCR of 8245?

Thanks,

Sam

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
