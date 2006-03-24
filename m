Return-Path: <Kallol_Biswas@pmc-sierra.com>
Received: from mother.pmc-sierra.bc.ca (mother.pmc-sierra.com [216.241.224.12])
	by ozlabs.org (Postfix) with SMTP id 4D4FC67A33
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Mar 2006 13:22:19 +1100 (EST)
Received: from bby1exi01.pmc_nt.nt.pmc-sierra.bc.ca
	(bby1exi01.pmc-sierra.bc.ca [216.241.231.251])
	by ogmios.pmc-sierra.bc.ca (8.13.3/8.12.7) with ESMTP id k2O2Fbpr017582
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Mar 2006 18:15:37 -0800
Message-ID: <478F19F21671F04298A2116393EEC3D50A9BE2@sjc1exm08.pmc_nt.nt.pmc-sierra.bc.ca>
From: Kallol Biswas <Kallol_Biswas@pmc-sierra.com>
To: linuxppc-dev@ozlabs.org
Subject: memory with __get_free_pages and disabling caching
Date: Thu, 23 Mar 2006 18:15:15 -0800
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----_=_NextPart_001_01C64EE8.CA1E663E"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This message is in MIME format. Since your mail reader does not understand
this format, some or all of this message may not be legible.

------_=_NextPart_001_01C64EE8.CA1E663E
Content-Type: text/plain

Hello,
       Is there an easy way to set page table attributes for the memory returned
by __get_free_pages()?
 
I need to be able to turn off caching and turn on E bit for these pages.
 
I tried to walk through the page tables data structures to get the pte, but it seems
that the pmd is not present for the pages. If someone has done investigation
on this before please send me a reply.
 
Thanks,
Kallol

------_=_NextPart_001_01C64EE8.CA1E663E
Content-Type: text/html

<!DOCTYPE HTML PUBLIC "-//W3C//DTD HTML 4.0 Transitional//EN">
<HTML><HEAD>
<META HTTP-EQUIV="Content-Type" CONTENT="text/html; charset=US-ASCII">


<META content="MSHTML 6.00.2800.1400" name=GENERATOR></HEAD>
<BODY>
<DIV><SPAN class=280060902-24032006><FONT face=Arial 
size=2>Hello,</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial 
size=2>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Is there an easy way to set page 
table attributes for the memory returned</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial size=2>by 
__get_free_pages()?</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial size=2>I need to be able to 
turn off caching and turn on E bit for these pages.</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial size=2>I tried to walk 
through the page tables data structures to get the pte, but it 
seems</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial size=2>that the pmd is not 
present for the pages. If someone has done investigation</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial size=2>on this before 
please send me a reply.</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial 
size=2></FONT></SPAN>&nbsp;</DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial 
size=2>Thanks,</FONT></SPAN></DIV>
<DIV><SPAN class=280060902-24032006><FONT face=Arial 
size=2>Kallol</FONT></SPAN></DIV></BODY></HTML>

------_=_NextPart_001_01C64EE8.CA1E663E--
