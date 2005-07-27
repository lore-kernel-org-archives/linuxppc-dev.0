Return-Path: <Ulrich.Kunkel@hbm.com>
Received: from mail.medianet-world.de (mail.medianet-world.de [213.157.0.167])
	by ozlabs.org (Postfix) with SMTP id 6633667D75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jul 2005 19:48:59 +1000 (EST)
Message-ID: <D3524C0FFDC6A54F9D7B6BBEECD341D505618A51@hbmntx0.da.hbm.com>
From: "Kunkel, Ulrich" <Ulrich.Kunkel@hbm.com>
To: "'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Date: Wed, 27 Jul 2005 11:42:15 +0200
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C5928F.7891B200"
Subject: FEC-trouble  with MPC5200 CRV400 M08A
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

------_=_NextPart_001_01C5928F.7891B200
Content-Type: text/plain

Hi everybody,   
we had a very fine system with the old Rev CBV400 2LR25. We can boot over
ethernet and do the transfer without any problems.
 
No we have the CRV400 M08A on the board. We just adapted the registers tfifo
and rfifo to 0x0F040000 and we use now the BAPIV2.2.
We use the elinos-kernel 2.4.25 with the new bestcom-files. We copied them
into the directory bestcom.
 
But in the most cases the board does not boot over ethernet. We see sig4 or
sig11 when linux starts init.
When we boot from flash we can see that a ping to the board with heavy loads
causes error, especialy when the board sends a ping to the server
simultaneous. There is mostly one false nibble in the data sections, mostly
at the borders of an ethernet-packet.
The error might a little rarer when using BAPI V2.2 instead of BAPI 2.1.
 
Any ideas? Thanks for Your help
 

Ulrich Kunkel

 

------_=_NextPart_001_01C5928F.7891B200
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=us-ascii">


<META content="MSHTML 6.00.2800.1505" name=GENERATOR></HEAD>
<BODY>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>Hi 
everybody,&nbsp;&nbsp;&nbsp;</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>we had a very fine 
system with the old Rev CBV400 2LR25. We can boot over ethernet and do the 
transfer without any problems.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=458541409-27072005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>No we have the 
CRV400 M08A on the board. We just adapted the registers tfifo and rfifo to 
0x0F040000 and we use now the BAPIV2.2.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>We use the 
elinos-kernel 2.4.25 with the new bestcom-files. We copied them into the 
directory bestcom.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN 
class=458541409-27072005></SPAN></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>But in the most 
cases the board does not boot over ethernet. We&nbsp;see sig4 or sig11 when 
linux starts init.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>When we boot from 
flash we can see that a ping to the board with heavy loads causes error, 
especialy when the board sends a ping to the server simultaneous. There is 
mostly one false nibble in the data sections, mostly at the borders of an 
ethernet-packet.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>The error might a 
little rarer when using BAPI V2.2 instead of BAPI 2.1.</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV><FONT face=Arial size=2><SPAN class=458541409-27072005>Any ideas? Thanks 
for Your help</SPAN></FONT></DIV>
<DIV><FONT face=Arial size=2></FONT>&nbsp;</DIV>
<DIV align=left>
<P class=MsoNormal style="MARGIN: 0cm 0cm 0pt; tab-stops: 42.6pt" align=left><B 
style="mso-bidi-font-weight: normal"><SPAN 
style="FONT-FAMILY: Arial; mso-bidi-font-family: 'Times New Roman'"><FONT 
size=2>Ulrich Kunkel</FONT></SPAN></B></P></DIV>
<DIV>&nbsp;</DIV></BODY></HTML>

------_=_NextPart_001_01C5928F.7891B200--
