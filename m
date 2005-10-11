Return-Path: <johan.derycke@barco.com>
Received: from kuuvir01.barco.com (kuu212123311.barco.com [212.123.3.11])
	by ozlabs.org (Postfix) with SMTP id 96629684FE
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 11 Oct 2005 17:02:22 +1000 (EST)
Message-ID: <81A66F72DCACD511B0600002A551BFCB08EE8AD4@kuumex05.barco.com>
From: "Derycke, Johan" <johan.derycke@barco.com>
To: achim.machura@berghof.com
Date: Tue, 11 Oct 2005 08:55:34 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5CE30.C72AE49A"
Cc: "Linuxppc-Embedded \(E-Mail\)" <linuxppc-embedded@ozlabs.org>
Subject: RE: MPC5200,PSC in uart mode, receiving problem
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C5CE30.C72AE49A
Content-Type: text/plain

Hi Achim,

I also have the problem with uart blocking.
Could you please send me your changes to the driver so I can see if it works
for me.

Best regards,

Johan

-----Original Message-----
From: linuxppc-embedded-bounces@ozlabs.org
[mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of Achim Machura
Sent: maandag 10 oktober 2005 15:14
To: 'Tomasz Prochownik'
Cc: Linuxppc-Embedded (E-Mail)
Subject: AW: MPC5200,PSC in uart mode, receiving problem

Hello Tomasz

> blocks (there is no response in the console).

perhaps we have the same problem a few times ago.
When we connect devices on ttySx which have wrong level on the lines the
uart stay in break mode.

I have made some fixes on the psc-driver. With these fixes the uart works,
but i don't know how efficient.
(clear breakmode and clear buffer)

If you want, i can send the code


best regards
achim

_______________________________________________
Linuxppc-embedded mailing list
Linuxppc-embedded@ozlabs.org
https://ozlabs.org/mailman/listinfo/linuxppc-embedded
- - - - - - - DISCLAIMER- - - - - - - -
Unless indicated otherwise, the information contained in this message is
privileged and confidential, and is intended only for the use of the
addressee(s) named above and others who have been specifically authorized to
receive it. If you are not the intended recipient, you are hereby notified
that any dissemination, distribution or copying of this message and/or
attachments is strictly prohibited. The company accepts no liability for any
damage caused by any virus transmitted by this email. Furthermore, the
company does not warrant a proper and complete transmission of this
information, nor does it accept liability for any delays. If you have
received this message in error, please contact the sender and delete the
message. Thank you.

------_=_NextPart_001_01C5CE30.C72AE49A
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.24">
<TITLE>RE: MPC5200,PSC in uart mode, receiving problem</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi Achim,</FONT>
</P>

<P><FONT SIZE=3D2>I also have the problem with uart blocking.</FONT>
<BR><FONT SIZE=3D2>Could you please send me your changes to the driver =
so I can see if it works for me.</FONT>
</P>

<P><FONT SIZE=3D2>Best regards,</FONT>
</P>

<P><FONT SIZE=3D2>Johan</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: linuxppc-embedded-bounces@ozlabs.org [<A =
HREF=3D"mailto:linuxppc-embedded-bounces@ozlabs.org">mailto:linuxppc-emb=
edded-bounces@ozlabs.org</A>] On Behalf Of Achim Machura</FONT>
<BR><FONT SIZE=3D2>Sent: maandag 10 oktober 2005 15:14</FONT>
<BR><FONT SIZE=3D2>To: 'Tomasz Prochownik'</FONT>
<BR><FONT SIZE=3D2>Cc: Linuxppc-Embedded (E-Mail)</FONT>
<BR><FONT SIZE=3D2>Subject: AW: MPC5200,PSC in uart mode, receiving =
problem</FONT>
</P>

<P><FONT SIZE=3D2>Hello Tomasz</FONT>
</P>

<P><FONT SIZE=3D2>&gt; blocks (there is no response in the =
console).</FONT>
</P>

<P><FONT SIZE=3D2>perhaps we have the same problem a few times =
ago.</FONT>
<BR><FONT SIZE=3D2>When we connect devices on ttySx which have wrong =
level on the lines the</FONT>
<BR><FONT SIZE=3D2>uart stay in break mode.</FONT>
</P>

<P><FONT SIZE=3D2>I have made some fixes on the psc-driver. With these =
fixes the uart works,</FONT>
<BR><FONT SIZE=3D2>but i don't know how efficient.</FONT>
<BR><FONT SIZE=3D2>(clear breakmode and clear buffer)</FONT>
</P>

<P><FONT SIZE=3D2>If you want, i can send the code</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>best regards</FONT>
<BR><FONT SIZE=3D2>achim</FONT>
</P>

<P><FONT =
SIZE=3D2>_______________________________________________</FONT>
<BR><FONT SIZE=3D2>Linuxppc-embedded mailing list</FONT>
<BR><FONT SIZE=3D2>Linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2><A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-embedded" =
TARGET=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-embedded<=
/A></FONT>
<BR><FONT SIZE=3D2>- - - - - - - DISCLAIMER- - - - - - - -</FONT>
<BR><FONT SIZE=3D2>Unless indicated otherwise, the information =
contained in this message is privileged and confidential, and is =
intended only for the use of the addressee(s) named above and others =
who have been specifically authorized to receive it. If you are not the =
intended recipient, you are hereby notified that any dissemination, =
distribution or copying of this message and/or attachments is strictly =
prohibited. The company accepts no liability for any damage caused by =
any virus transmitted by this email. Furthermore, the company does not =
warrant a proper and complete transmission of this information, nor =
does it accept liability for any delays. If you have received this =
message in error, please contact the sender and delete the message. =
Thank you.</FONT></P>

</BODY>
</HTML>
------_=_NextPart_001_01C5CE30.C72AE49A--
