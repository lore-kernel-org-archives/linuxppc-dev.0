Return-Path: <johan.derycke@barco.com>
Received: from kuuvir01.barco.com (unknown.barco.com [194.7.240.10])
	by ozlabs.org (Postfix) with SMTP id 7365C683F0
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  3 Oct 2005 23:54:31 +1000 (EST)
Message-ID: <81A66F72DCACD511B0600002A551BFCB08D9613C@kuumex05.barco.com>
From: "Derycke, Johan" <johan.derycke@barco.com>
To: Andrew Dennison <andrewd.lists@gmail.com>
Date: Mon, 3 Oct 2005 15:56:21 +0200 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5C822.3C73D1D6"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: mpc5200 and pcmcia
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

------_=_NextPart_001_01C5C822.3C73D1D6
Content-Type: text/plain

Hi Andrew,

I am looking forward to your patch. 
If there is anything you want me to test let me know...
Does it support 32bit cards?

Br,

Johan


-----Original Message-----
From: Andrew Dennison [mailto:andrewd.lists@gmail.com] 
Sent: donderdag 29 september 2005 1:26
To: Derycke, Johan
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: mpc5200 and pcmcia

On 9/28/05, Derycke, Johan <johan.derycke@barco.com> wrote:
>
> I am working on a custom board based on the Lite5200.
> It is expanded with a PCI1410 PC Card Controller on the PCI bus.
>
> In the history of this list I found a patch against an older kernel
version
> to solve some issues:
> http://ozlabs.org/pipermail/linuxppc-embedded/2004-December/016273.html
>
> I took the old 2.4.23 kernel and applied the patch.
> I could get my 3c589 network adaptor to work.

Nice to get some feedback, Your the second person that has used it.

> Is this patch available for the current 2.4.25 kernel?
>

It will work conceptually with 2.4.25 as I'm currently running a
relatively recent denx kernel with similar changes. I haven't
published a recent patch yet as there wasn't much feedback last
time...

I've recently done some more work on this to clean it up, for example
USB didn't work with that previous patch but they now coesist happily.

I'll look at posting a patch soon when it's merged into my shiny new GIT
tree.

Andrew
- - - - - - - DISCLAIMER - - - - - - - -
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

------_=_NextPart_001_01C5C822.3C73D1D6
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3Dus-ascii">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.24">
<TITLE>RE: mpc5200 and pcmcia</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Hi Andrew,</FONT>
</P>

<P><FONT SIZE=3D2>I am looking forward to your patch. </FONT>
<BR><FONT SIZE=3D2>If there is anything you want me to test let me =
know...</FONT>
<BR><FONT SIZE=3D2>Does it support 32bit cards?</FONT>
</P>

<P><FONT SIZE=3D2>Br,</FONT>
</P>

<P><FONT SIZE=3D2>Johan</FONT>
</P>
<BR>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Andrew Dennison [<A =
HREF=3D"mailto:andrewd.lists@gmail.com">mailto:andrewd.lists@gmail.com</=
A>] </FONT>
<BR><FONT SIZE=3D2>Sent: donderdag 29 september 2005 1:26</FONT>
<BR><FONT SIZE=3D2>To: Derycke, Johan</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Subject: Re: mpc5200 and pcmcia</FONT>
</P>

<P><FONT SIZE=3D2>On 9/28/05, Derycke, Johan =
&lt;johan.derycke@barco.com&gt; wrote:</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; I am working on a custom board based on the =
Lite5200.</FONT>
<BR><FONT SIZE=3D2>&gt; It is expanded with a PCI1410 PC Card =
Controller on the PCI bus.</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; In the history of this list I found a patch =
against an older kernel version</FONT>
<BR><FONT SIZE=3D2>&gt; to solve some issues:</FONT>
<BR><FONT SIZE=3D2>&gt; <A =
HREF=3D"http://ozlabs.org/pipermail/linuxppc-embedded/2004-December/0162=
73.html" =
TARGET=3D"_blank">http://ozlabs.org/pipermail/linuxppc-embedded/2004-Dec=
ember/016273.html</A></FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
<BR><FONT SIZE=3D2>&gt; I took the old 2.4.23 kernel and applied the =
patch.</FONT>
<BR><FONT SIZE=3D2>&gt; I could get my 3c589 network adaptor to =
work.</FONT>
</P>

<P><FONT SIZE=3D2>Nice to get some feedback, Your the second person =
that has used it.</FONT>
</P>

<P><FONT SIZE=3D2>&gt; Is this patch available for the current 2.4.25 =
kernel?</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>It will work conceptually with 2.4.25 as I'm =
currently running a</FONT>
<BR><FONT SIZE=3D2>relatively recent denx kernel with similar changes. =
I haven't</FONT>
<BR><FONT SIZE=3D2>published a recent patch yet as there wasn't much =
feedback last</FONT>
<BR><FONT SIZE=3D2>time...</FONT>
</P>

<P><FONT SIZE=3D2>I've recently done some more work on this to clean it =
up, for example</FONT>
<BR><FONT SIZE=3D2>USB didn't work with that previous patch but they =
now coesist happily.</FONT>
</P>

<P><FONT SIZE=3D2>I'll look at posting a patch soon when it's merged =
into my shiny new GIT tree.</FONT>
</P>

<P><FONT SIZE=3D2>Andrew</FONT>
<BR><FONT SIZE=3D2>- - - - - - - DISCLAIMER - - - - - - - -</FONT>
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
------_=_NextPart_001_01C5C822.3C73D1D6--
