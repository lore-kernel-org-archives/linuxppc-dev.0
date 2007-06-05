Return-Path: <huangxiaoguang@datangmobile.cn>
Received: from mail.datangmobile.cn (unknown [219.142.67.62])
	by ozlabs.org (Postfix) with ESMTP id A68F4DDDFA
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Jun 2007 14:59:12 +1000 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C7A72C.91ACB0CD"
Subject: Is there anybody use rt-preempt patch on freescale ppc successfully?
Date: Tue, 5 Jun 2007 12:47:06 +0800
Message-ID: <D728AD1FA2543948B89DE29C5BF4CD070C0C42AB@bjmail1.bj.datangmobile.com>
From: <huangxiaoguang@datangmobile.cn>
To: <linuxppc-embedded@ozlabs.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C7A72C.91ACB0CD
Content-Type: text/plain;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

Hello,all
=20
I applied linux 2.6.21 and Ingo's patch 2.6.21-rt1 on ppc8260, It can't =
be complied successfully=20
when I used ARCH=3Dppc, and the patch can work when using =
ARCH=3Dpowerpc.=20
=20
When using powerpc, the maximum latency of interrupt and preemption are =
all increased, about 5ms,
regardless patch was applied or not.
=20
Does the rt patch not fit ppc, or I used it incorrect?
=20
Thanks.
=20
=20
=20
=20

------_=_NextPart_001_01C7A72C.91ACB0CD
Content-Type: text/html;
	charset="gb2312"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; charset=3Dgb2312">
<META content=3D"MSHTML 6.00.2900.3086" name=3DGENERATOR></HEAD>
<BODY>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2>Hello,all</FONT></SPAN></DIV>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D109560704-05062007><FONT size=3D2>I applied linux =
2.6.21 and=20
Ingo's patch 2.6.21-rt1 on ppc8260, It can't be complied successfully=20
</FONT></SPAN></DIV>
<DIV><SPAN class=3D109560704-05062007><FONT size=3D2>when I used =
ARCH=3Dppc, and the=20
patch can work when&nbsp;using ARCH=3Dpowerpc. </FONT></SPAN></DIV>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D109560704-05062007><FONT size=3D2>When using powerpc, =
the maximum=20
latency of interrupt and preemption are all increased, about=20
5ms,</FONT></SPAN></DIV>
<DIV><SPAN class=3D109560704-05062007><FONT size=3D2>regardless patch =
was applied or=20
not.</FONT></SPAN></DIV>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D109560704-05062007><FONT size=3D2>Does the rt patch =
not fit ppc,=20
or I used it incorrect?</FONT></SPAN></DIV>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2>Thanks.</FONT></SPAN></DIV>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=3D109560704-05062007><FONT =
size=3D2></FONT></SPAN>&nbsp;</DIV>
<DIV>&nbsp;</DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><FONT size=3D2></FONT>&nbsp;</DIV></DIV></BODY></HTML>

------_=_NextPart_001_01C7A72C.91ACB0CD--
