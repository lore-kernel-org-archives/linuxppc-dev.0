Return-Path: <Atit_Shah@satyam.com>
Received: from njpmail.satyam.com (njpmail.satyam.com [204.179.188.132])
	by ozlabs.org (Postfix) with ESMTP id 8419D67A6B
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 23:48:32 +1000 (EST)
Message-ID: <A44765C986F8D411995B00B0D0795F4B3A828132@hhtnt002>
From: Atit_Shah <Atit_Shah@satyam.com>
To: Eugene Surovegin <ebs@ebshome.net>
Date: Tue, 5 Apr 2005 19:18:05 +0530 
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C539E6.174CA54C"
Cc: linuxppc-embedded@ozlabs.org
Subject: RE: Problem with linux porting
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

------_=_NextPart_001_01C539E6.174CA54C
Content-Type: text/plain

sorry the bus and input frequenies are same and its 100MHz. 

yes it is the clkin freq

-----Original Message-----
From: Eugene Surovegin [mailto:ebs@ebshome.net] 
Sent: Tuesday, April 05, 2005 3:31 PM
To: Atit_Shah
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem with linux porting

On Tue, Apr 05, 2005 at 02:24:01PM +0530, Atit_Shah wrote:
> We are having a problem with porting of Linux.

[snip]

> 4. Frequency
> 
>             Core:  346MHz
> 
>             CPM:   198MHz
> 
>             BUS:   99MHz
> 
>             Input: 66MHz

What does "Input" clock mean?

If it's a CLKIN, why is Bus clock not equal to it?

--
Eugene

************************************************************************** 
This email (including any attachments) is intended for the sole use of the
intended recipient/s and may contain material that is CONFIDENTIAL AND
PRIVATE COMPANY INFORMATION. Any review or reliance by others or copying or
distribution or forwarding of any or all of the contents in this message is
STRICTLY PROHIBITED. If you are not the intended recipient, please contact
the sender by email and delete all copies; your cooperation in this regard
is appreciated.
**************************************************************************

------_=_NextPart_001_01C539E6.174CA54C
Content-Type: text/html
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DUS-ASCII">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>RE: Problem with linux porting</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>sorry the bus and input frequenies are same and its =
100MHz. </FONT>
</P>

<P><FONT SIZE=3D2>yes it is the clkin freq</FONT>
</P>

<P><FONT SIZE=3D2>-----Original Message-----</FONT>
<BR><FONT SIZE=3D2>From: Eugene Surovegin [<A =
HREF=3D"mailto:ebs@ebshome.net">mailto:ebs@ebshome.net</A>] </FONT>
<BR><FONT SIZE=3D2>Sent: Tuesday, April 05, 2005 3:31 PM</FONT>
<BR><FONT SIZE=3D2>To: Atit_Shah</FONT>
<BR><FONT SIZE=3D2>Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>Subject: Re: Problem with linux porting</FONT>
</P>

<P><FONT SIZE=3D2>On Tue, Apr 05, 2005 at 02:24:01PM +0530, Atit_Shah =
wrote:</FONT>
<BR><FONT SIZE=3D2>&gt; We are having a problem with porting of =
Linux.</FONT>
</P>

<P><FONT SIZE=3D2>[snip]</FONT>
</P>

<P><FONT SIZE=3D2>&gt; 4. Frequency</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; Core:&nbsp; 346MHz</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; CPM:&nbsp;&nbsp; 198MHz</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; BUS:&nbsp;&nbsp; 99MHz</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT =
SIZE=3D2>&gt;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp=
;&nbsp;&nbsp; Input: 66MHz</FONT>
</P>

<P><FONT SIZE=3D2>What does &quot;Input&quot; clock mean?</FONT>
</P>

<P><FONT SIZE=3D2>If it's a CLKIN, why is Bus clock not equal to =
it?</FONT>
</P>

<P><FONT SIZE=3D2>--</FONT>
<BR><FONT SIZE=3D2>Eugene</FONT>
</P>

<P><FONT =
SIZE=3D2>***************************************************************=
*********** </FONT>
<BR><FONT SIZE=3D2>This email (including any attachments) is intended =
for the sole use of the intended recipient/s and may contain material =
that is CONFIDENTIAL AND PRIVATE COMPANY INFORMATION. Any review or =
reliance by others or copying or distribution or forwarding of any or =
all of the contents in this message is STRICTLY PROHIBITED. If you are =
not the intended recipient, please contact the sender by email and =
delete all copies; your cooperation in this regard is =
appreciated.</FONT></P>

<P><FONT =
SIZE=3D2>***************************************************************=
***********</FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C539E6.174CA54C--
