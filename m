Return-Path: <Gehirnmann@gmx.de>
Received: from mail.gmx.net (pop.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id 579C9679E7
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 May 2005 21:59:10 +1000 (EST)
Date: Wed, 25 May 2005 13:59:08 +0200 (MEST)
From: "Peter Gehirnforce" <Gehirnmann@gmx.de>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Message-ID: <16216.1117022348@www12.gmx.net>
Content-Type: text/plain; charset="us-ascii"
Subject: depmod.pl fails with "base directory does not match" (2_4_devel)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all,

since now I used modules compiled into the kernel for ppc_6xx.
for debugging I'd like to use dynamic loading, but when doing:
make modules_install
the depmod.pl fails with "base directory does not match ..../lib/modules"
As far as I could find out, the modules get copied to the base /lib path,
even with $PATH and $CROSS_COMPILE set correctly (I used compiled modules
successfully).
Whats wrong with my attempt? is there some cross-compile tool to do the job
of depmod.pl?

GM

-- 
5 GB Mailbox, 50 FreeSMS http://www.gmx.net/de/go/promail
+++ GMX - die erste Adresse für Mail, Message, More +++
