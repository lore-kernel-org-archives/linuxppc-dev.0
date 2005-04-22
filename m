Return-Path: <pstudencki@yahoo.com>
Received: from web51302.mail.yahoo.com (web51302.mail.yahoo.com
	[206.190.38.168]) by ozlabs.org (Postfix) with SMTP id D8B1167A6B
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 22 Apr 2005 22:45:20 +1000 (EST)
Message-ID: <20050422124518.14595.qmail@web51302.mail.yahoo.com>
Date: Fri, 22 Apr 2005 05:45:17 -0700 (PDT)
From: Pawel Studencki <pstudencki@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Subject: Support for FEC in 2.6.x Kernel - status?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello,
 
could somebody give me some information about current
status of FEC support
in 2.6.x kernels for 8xx?
 
What I've already found:
-some code in arch/ppc/8xx_io, but it seems that it
isn't up to date. 
- moreover there is a patch from Pantelis Antoniou,
FEC driver was moved to
driver/net/fec_8xx. Currently I'm working with it, but
it fails in function
driver_attach called from fec_8xx_init.
- and there is also a patch to Abstract Ethernet PHY
support (using driver
model) by Andy Fleming

best regards
Pawel

__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around 
http://mail.yahoo.com 
