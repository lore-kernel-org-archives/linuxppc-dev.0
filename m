Return-Path: <jm.capitan@ateme.com>
Received: from smtp-ext.ateme.net (smtp-ext.ateme.net [217.167.236.59])
	by ozlabs.org (Postfix) with ESMTP id 44202DDEE7
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Dec 2008 21:27:57 +1100 (EST)
Received: from smtp-in.ateme.net (lserver.ateme.net [172.16.0.1])
	by smtp-ext.ateme.net (Postfix) with ESMTP id 3E9AB1063E5
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Dec 2008 11:09:27 +0100 (CET)
Received: from PC379 (pc-379.ateme.net [172.16.17.124])
	by smtp-in.ateme.net (Postfix) with ESMTP id D14E334309
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  9 Dec 2008 11:09:26 +0100 (CET)
From: "Jean-Michel CAPITAN" <jm.capitan@ateme.com>
To: <linuxppc-embedded@ozlabs.org>
Subject: Re: LocalPlus or XLB-Arbiter Problems, DMA, MPC5200, DENX' 2.4.25
Date: Tue, 9 Dec 2008 11:04:41 +0100
Message-ID: <999314E6D4AE4027A400F19B7D986F9E@PC379>
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_NextPart_000_00D9_01C959ED.EF4DE2F0"
Reply-To: jm.capitan@ateme.com
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

------=_NextPart_000_00D9_01C959ED.EF4DE2F0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit

Hi,
We have discovered we have the same issu you had on one of our systems.
Did you fix it on your side ?
 
 
Regards,
 
 
Hello,



We've got the following problem:



MPC5200CBV400 L25R Rev 2



Using the DENX 2.4.25 with FEC and ATA DMA, BAPI 2.2, Prios are set to

FEC 6/5 and ATA 4/3 (RX/TX). This causes the FEC task to interrupt the

ATA task (default).



We try to load both tasks by transferring data from the ATA disk to

the Ethernet, e.g. by using FTP.



At the same time we write to some peripheral on the LocalPlus from

within a cyclic timer tasklet.





>From time to time writing to the external peripheral fails, there is a

bus cycle, but we write some wrong data. This only happens if we have

FEC+ATA active at the same time.



Increasing the ATA priorities above the FEC priorities gives us FEC

errors, but the external peripheral works.





I'm sure others have similar problems. Did any of you change the

priority setting of these tasks to be able to run her/his hardware? Is

this related to the XLB pipelining problem as described in the errata

and previous mails in this list? Does anybody know if this problem is

fixed in newer revisions of the chip? Could be disabling pipelining

and waiting for TIP to go away help as well?





Thanks for any help.





Roman
 

------=_NextPart_000_00D9_01C959ED.EF4DE2F0
Content-Type: text/html;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META http-equiv=3DContent-Type content=3D"text/html; =
charset=3Dus-ascii">
<META content=3D"MSHTML 6.00.2900.5659" name=3DGENERATOR></HEAD>
<BODY>
<DIV><FONT face=3DArial><PRE><SPAN class=3D937020410-09122008><FONT =
size=3D2>Hi,</FONT></SPAN></PRE><PRE><SPAN =
class=3D937020410-09122008><FONT size=3D2>We have discovered we have the =
same issu you had on one of our systems.</FONT></SPAN></PRE><PRE><SPAN =
class=3D937020410-09122008><FONT size=3D2>Did you fix it on your side =
?</FONT></SPAN></PRE><PRE><SPAN class=3D937020410-09122008><FONT =
size=3D2></FONT></SPAN>&nbsp;</PRE><PRE><SPAN =
class=3D937020410-09122008><FONT =
size=3D2></FONT></SPAN>&nbsp;</PRE><PRE><SPAN =
class=3D937020410-09122008><FONT =
size=3D2>Regards,</FONT></SPAN></PRE><PRE><FONT =
size=3D2></FONT>&nbsp;</PRE><PRE><FONT =
size=3D2></FONT>&nbsp;</PRE><PRE><FONT size=3D2>Hello,

We've got the following problem:

MPC5200CBV400 L25R Rev 2

Using the DENX 2.4.25 with FEC and ATA DMA, BAPI 2.2, Prios are set to
FEC 6/5 and ATA 4/3 (RX/TX). This causes the FEC task to interrupt the
ATA task (default).

We try to load both tasks by transferring data from the ATA disk to
the Ethernet, e.g. by using FTP.

At the same time we write to some peripheral on the LocalPlus from
within a cyclic timer tasklet.


>From time to time writing to the external peripheral fails, there is a
bus cycle, but we write some wrong data. This only happens if we have
FEC+ATA active at the same time.

Increasing the ATA priorities above the FEC priorities gives us FEC
errors, but the external peripheral works.


I'm sure others have similar problems. Did any of you change the
priority setting of these tasks to be able to run her/his hardware? Is
this related to the XLB pipelining problem as described in the errata
and previous mails in this list? Does anybody know if this problem is
fixed in newer revisions of the chip? Could be disabling pipelining
and waiting for TIP to go away help as well?


Thanks for any help.


Roman</FONT></PRE></FONT></DIV>
<DIV>
<DIV align=3Dleft><FONT face=3DArial color=3D#0080ff =
size=3D2></FONT></DIV><FONT=20
face=3DArial size=3D2></FONT></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------=_NextPart_000_00D9_01C959ED.EF4DE2F0--
