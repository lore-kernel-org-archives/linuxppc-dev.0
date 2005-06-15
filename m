Return-Path: <awilliam@nortel.com>
Received: from zcars04e.ca.nortel.com (zcars04e.nortelnetworks.com
	[47.129.242.56])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1519C67B41
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Jun 2005 03:04:42 +1000 (EST)
Received: from zcard305.ca.nortel.com (zcard305.ca.nortel.com [47.129.242.61])
	by zcars04e.ca.nortel.com (Switch-2.2.0/Switch-2.2.0) with ESMTP id
	j5FH3cV03160 for <linuxppc-embedded@ozlabs.org>;
	Wed, 15 Jun 2005 13:03:38 -0400 (EDT)
Message-ID: <713043CE8B8E1348AF3C546DBE02C1B403C657CC@zcarhxm2.corp.nortel.com>
From: "Andrew Williams" <awilliam@nortel.com>
To: linuxppc-embedded@ozlabs.org
Date: Wed, 15 Jun 2005 13:04:27 -0400
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C571CC.4A0C053E"
Subject: RE: 2.4.26 and MPC885 context switching time
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

------_=_NextPart_001_01C571CC.4A0C053E
Content-Type: text/plain;
	charset="ISO-8859-1"

Question embedded below..

> -----Original Message-----
> From: linuxppc-embedded-bounces@ozlabs.org 
> [mailto:linuxppc-embedded-bounces@ozlabs.org] On Behalf Of 
> Martin Krause
> Sent: June 15, 2005 11:12 AM
> To: Schaefer-Hutter, Peter
> Cc: linuxppc-embedded@ozlabs.org
> Subject: AW: 2.4.26 and MPC885 context switching time
> 
> 
> Hi Peter,
> 
> linuxppc-embedded-bounces@ozlabs.org wrote on :
> > i'm evaluating IPC on the MPC885ADS and discovered
> > that the context switching times seem to be quite 
> disappointing (up to 
> > 1ms). As we need to do a lot
> .. 
> > Or is this the expected context switching time for
> > CPU @ 100 MHz (RAM @ 50 MHz)? Suggestions for a
> > benchmark program?
> 
> Denx has done some detailed performance measurements 
> (including context switching). You could find the report 
> here: http://www.denx.de/twiki/bin/view/Know/Linux24vs26.
> Hope that is of some help.
>

Has anything changed with 2.6 in the last 12 months that 
would alter the conclusions presented in this article?

A.

 
> Regards,
> Martin
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org 
> https://ozlabs.org/mailman/listinfo/linuxppc-> embedded
> 
> 

------_=_NextPart_001_01C571CC.4A0C053E
Content-Type: text/html;
	charset="ISO-8859-1"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 3.2//EN">
<HTML>
<HEAD>
<META HTTP-EQUIV=3D"Content-Type" CONTENT=3D"text/html; =
charset=3DISO-8859-1">
<META NAME=3D"Generator" CONTENT=3D"MS Exchange Server version =
5.5.2658.2">
<TITLE>RE: 2.4.26 and MPC885 context switching time</TITLE>
</HEAD>
<BODY>

<P><FONT SIZE=3D2>Question embedded below..</FONT>
</P>

<P><FONT SIZE=3D2>&gt; -----Original Message-----</FONT>
<BR><FONT SIZE=3D2>&gt; From: linuxppc-embedded-bounces@ozlabs.org =
</FONT>
<BR><FONT SIZE=3D2>&gt; [<A =
HREF=3D"mailto:linuxppc-embedded-bounces@ozlabs.org">mailto:linuxppc-emb=
edded-bounces@ozlabs.org</A>] On Behalf Of </FONT>
<BR><FONT SIZE=3D2>&gt; Martin Krause</FONT>
<BR><FONT SIZE=3D2>&gt; Sent: June 15, 2005 11:12 AM</FONT>
<BR><FONT SIZE=3D2>&gt; To: Schaefer-Hutter, Peter</FONT>
<BR><FONT SIZE=3D2>&gt; Cc: linuxppc-embedded@ozlabs.org</FONT>
<BR><FONT SIZE=3D2>&gt; Subject: AW: 2.4.26 and MPC885 context =
switching time</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Hi Peter,</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; linuxppc-embedded-bounces@ozlabs.org wrote on =
:</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; i'm evaluating IPC on the MPC885ADS and =
discovered</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; that the context switching times seem to =
be quite </FONT>
<BR><FONT SIZE=3D2>&gt; disappointing (up to </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; 1ms). As we need to do a lot</FONT>
<BR><FONT SIZE=3D2>&gt; .. </FONT>
<BR><FONT SIZE=3D2>&gt; &gt; Or is this the expected context switching =
time for</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; CPU @ 100 MHz (RAM @ 50 MHz)? Suggestions =
for a</FONT>
<BR><FONT SIZE=3D2>&gt; &gt; benchmark program?</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; Denx has done some detailed performance =
measurements </FONT>
<BR><FONT SIZE=3D2>&gt; (including context switching). You could find =
the report </FONT>
<BR><FONT SIZE=3D2>&gt; here: <A =
HREF=3D"http://www.denx.de/twiki/bin/view/Know/Linux24vs26" =
TARGET=3D"_blank">http://www.denx.de/twiki/bin/view/Know/Linux24vs26</A>=
.</FONT>
<BR><FONT SIZE=3D2>&gt; Hope that is of some help.</FONT>
<BR><FONT SIZE=3D2>&gt;</FONT>
</P>

<P><FONT SIZE=3D2>Has anything changed with 2.6 in the last 12 months =
that </FONT>
<BR><FONT SIZE=3D2>would alter the conclusions presented in this =
article?</FONT>
</P>

<P><FONT SIZE=3D2>A.</FONT>
</P>

<P><FONT SIZE=3D2>&nbsp;</FONT>
<BR><FONT SIZE=3D2>&gt; Regards,</FONT>
<BR><FONT SIZE=3D2>&gt; Martin</FONT>
<BR><FONT SIZE=3D2>&gt; =
_______________________________________________</FONT>
<BR><FONT SIZE=3D2>&gt; Linuxppc-embedded mailing list</FONT>
<BR><FONT SIZE=3D2>&gt; Linuxppc-embedded@ozlabs.org </FONT>
<BR><FONT SIZE=3D2>&gt; <A =
HREF=3D"https://ozlabs.org/mailman/listinfo/linuxppc-" =
TARGET=3D"_blank">https://ozlabs.org/mailman/listinfo/linuxppc-</A>&gt; =
embedded</FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
<BR><FONT SIZE=3D2>&gt; </FONT>
</P>

</BODY>
</HTML>
------_=_NextPart_001_01C571CC.4A0C053E--
