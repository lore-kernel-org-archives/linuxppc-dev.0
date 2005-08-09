Return-Path: <erickampman@yahoo.com>
Received: from web41211.mail.yahoo.com (web41211.mail.yahoo.com [66.218.93.44])
	by ozlabs.org (Postfix) with SMTP id 62B4267EE5
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 10 Aug 2005 00:11:10 +1000 (EST)
Message-ID: <20050809140428.13450.qmail@web41211.mail.yahoo.com>
Date: Tue, 9 Aug 2005 07:04:27 -0700 (PDT)
From: Eric Kampman <erickampman@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: MPC8555CDS & CCSRBAR
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Trying to port an SEC driver to Linux/PPC8555. Reading
the default CCSRBAR @ 0xFF700000 I read 0xFFFFFFFF
which is wrong. Looking at Metrowerks init files and
uboot code (1.1.2) I see it's likely been moved to
0xE0000000, but I get a seg fault when I try to read
there. 

So, what am I doing wrong, and even better, how do I
at runtime find out where CCSRBAR is? Thanks in
advance, and please forgive the likely ignorance, 

Eric


		
____________________________________________________
Start your day with Yahoo! - make it your home page 
http://www.yahoo.com/r/hs 
 
