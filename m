Return-Path: <jean-philippe.jacquemin@barco.com>
Received: from kuumail.barco.com (kuumail.barco.com [32.58.34.195])
	by ozlabs.org (Postfix) with SMTP id 640E2DDEDA
	for <linuxppc-dev@ozlabs.org>; Tue, 31 Mar 2009 21:04:03 +1100 (EST)
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C9B1E4.99FDBFB6"
Subject: configuring the DMA for using the SCPLC on the MPC5121
Date: Tue, 31 Mar 2009 11:39:34 +0200
Message-ID: <ED2EA636E2C9744A96B417491D4793BB04E16C26@KUUMEX03.barco.com>
From: "Jacquemin, Jean-Philippe" <jean-philippe.jacquemin@barco.com>
To: <linuxppc-dev@ozlabs.org>
Cc: "Loridon, Martin" <martin.loridon@barco.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------_=_NextPart_001_01C9B1E4.99FDBFB6
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

Dear all,
=20
I am trying to configure the MPC5121 to perform DMA transfers from the
CPU RAM to the RAM of an FPGA attached on ChipSelect 2.
I have to use the LocalPlus Bus and configure the chipselect2 for bust
mode and non-multiplexed.
I also have to configure a DMA task to copy the content of my buffer to
the local bus Fifo and then kick this content to the wanted address on
chipselect 2.
=20
I have some code (thanks to Grant Likely) to implement a LocalPlus Bus
Fifo driver (SCPLC) but have no clue how to configure the DMA for using
the SCPLC... Can someone help me??
=20
The 5121 fifo is directly derived from the 5200 fifo, only it is :
* deeper (1024bytes instead of 512),=20
* up to 56 bytes can be transfered with one transaction
* increased SCPLC packet size register to 31 bits
=20
=20
best regards,
=20
Jean-Philippe Jacquemin
=20


DISCLAIMER:
Unless indicated otherwise, the information contained in this message is =
privileged and confidential, and is intended only for the use of the =
addressee(s) named above and others who have been specifically =
authorized to receive it. If you are not the intended recipient, you are =
hereby notified that any dissemination, distribution or copying of this =
message and/or attachments is strictly prohibited. The company accepts =
no liability for any damage caused by any virus transmitted by this =
email. Furthermore, the company does not warrant a proper and complete =
transmission of this information, nor does it accept liability for any =
delays. If you have received this message in error, please contact the =
sender and delete the message. Thank you.

------_=_NextPart_001_01C9B1E4.99FDBFB6
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.3492" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009>Dear=20
all,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN =
class=3D778552409-31032009></SPAN></FONT><FONT=20
face=3DArial size=3D2><SPAN =
class=3D778552409-31032009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009>I am =
trying to=20
configure the MPC5121 to perform DMA transfers from the CPU RAM to the =
RAM of an=20
FPGA attached on ChipSelect 2.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009>I have =
to use the=20
LocalPlus Bus and configure the chipselect2 for bust mode and=20
non-multiplexed.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009>I also =
have to=20
configure a DMA task to copy the content of my buffer to the local bus =
Fifo and=20
then kick this content to the wanted address on chipselect=20
2.</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D778552409-31032009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009>I have =
some code=20
(thanks to&nbsp;Grant Likely) to implement a LocalPlus Bus Fifo driver =
(SCPLC)=20
but have no clue how to configure the DMA for using the SCPLC... Can =
someone=20
help me??</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009><FONT=20
size=3D2></FONT></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009><FONT =
size=3D2>The=20
5121 fifo is directly derived from the 5200 fifo, only it=20
is&nbsp;:</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009><FONT =
size=3D2>*=20
deeper (1024bytes instead of 512), </FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009><FONT =
size=3D2>* up to=20
56 bytes can be transfered with one =
transaction</FONT></SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009><FONT =
size=3D2>*=20
increased SCPLC packet size register to&nbsp;31 =
bits</DIV></FONT></SPAN></FONT>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D778552409-31032009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN=20
class=3D778552409-31032009></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=3DArial size=3D2><SPAN class=3D778552409-31032009>best=20
regards,</SPAN></FONT></DIV>
<DIV><FONT face=3DArial size=3D2></FONT>&nbsp;</DIV>
<DIV align=3Dleft>
<DIV align=3Dleft><FONT face=3DArial size=3D2><SPAN =
class=3D570311614-19032008><SPAN=20
class=3D735275811-21032008>Jean-Philippe=20
Jacquemin</SPAN></SPAN></FONT></DIV></DIV>
<DIV>&nbsp;</DIV><p></p><p>DISCLAIMER:<br>Unless indicated otherwise, =
the information contained in this message is privileged and =
confidential, and is intended only for the use of the addressee(s) named =
above and others who have been specifically authorized to receive it. If =
you are not the intended recipient, you are hereby notified that any =
dissemination, distribution or copying of this message and/or =
attachments is strictly prohibited. The company accepts no liability for =
any damage caused by any virus transmitted by this email. Furthermore, =
the company does not warrant a proper and complete transmission of this =
information, nor does it accept liability for any delays. If you have =
received this message in error, please contact the sender and delete the =
message. Thank you.</BODY></HTML>

------_=_NextPart_001_01C9B1E4.99FDBFB6--
