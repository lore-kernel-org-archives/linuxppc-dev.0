Return-Path: <mcnernbm@notes.udayton.edu>
Received: from student03.udayton.edu (student03.udayton.edu [131.238.75.43])
	by ozlabs.org (Postfix) with ESMTP id 2C6B767A76
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 08:15:52 +1100 (EST)
MIME-Version: 1.0
From: mcnernbm@notes.udayton.edu
To: linuxppc-embedded@ozlabs.org
Date: Thu, 5 Jan 2006 16:00:38 -0500
Message-ID: <OF4583615F.8ED595CE-ON852570ED.00736A17-852570ED.00736A1D@notes.udayton.edu>
MIME-Version: 1.0
Content-Type: text/html;
	charset=ISO-8859-1
Subject: io.h question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

<FONT face=3D"Default Sans Serif,Verdana,Arial,Helvetica,sans-serif" size=
=3D2><div>I finally noticed out=5F8 and in=5F8 and what not are located in =
the ppc io.h file in the kernel development download.&nbsp; But when I trie=
d to do a io.h with in my program I added #include &lt;asm/io.h&gt;&nbsp; a=
nd it seems to find it with not problems but it can not find the functions =
with in that file.&nbsp; Am i missing a define I need to set or something s=
o I can see the right files with in io.h I am compiling for a ppc405 on a x=
ilinx virtex 4 board.</div><DIV>Thanks</DIV><DIV>Brett</DIV></FONT>=
