Return-Path: <emrekara2002@yahoo.co.uk>
Received: from web25710.mail.ukl.yahoo.com (web25710.mail.ukl.yahoo.com
	[217.12.10.182]) by ozlabs.org (Postfix) with SMTP id CF1D467A2F
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 12 Feb 2005 01:01:43 +1100 (EST)
Message-ID: <20050211135501.19902.qmail@web25710.mail.ukl.yahoo.com>
Date: Fri, 11 Feb 2005 13:55:01 +0000 (GMT)
From: emre kara <emrekara2002@yahoo.co.uk>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: 1000MB (GMII) ports on IBM 440GX (ocotea) 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear All;
I have problems on ppc440gx ( IBM 440gx evaluatation
board)  gigabit ethernet ports.
I have configurated and compiled linux kernel version
2.4.29 (latest) for ocotea board and it worked fine
with two MII /Fast Ethernet ports,but i can't find any
way to configure GMII (gigabit) ethernet driver for
other on chip two gigabit ports, in the platform
specific file (arch/ppc/platforms/ocotea.c) the source
configures only two fast ethernet ports.
I have also loaded Montavista's preview kernel on my
board and in this kernel,  four ethernet ports worked
fine, but there are huge differences between two
kernels so I can't find a way to overcome this
problem.
Is anyone have an idea for the solution?
Thank you.
Emre




	
	
		
___________________________________________________________ 
ALL-NEW Yahoo! Messenger - all new features - even more fun! http://uk.messenger.yahoo.com
