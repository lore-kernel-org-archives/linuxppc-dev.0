Return-Path: <jsteve17@yahoo.com>
Received: from web33411.mail.mud.yahoo.com (web33411.mail.mud.yahoo.com
	[68.142.206.143]) by ozlabs.org (Postfix) with SMTP id EB7E967C20
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 16 Oct 2006 01:02:20 +1000 (EST)
Message-ID: <20061015150217.17117.qmail@web33411.mail.mud.yahoo.com>
Date: Sun, 15 Oct 2006 08:02:17 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
Subject: asm-ppc includes
To: ELDK Mailing List <linuxppc-embedded@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I have a AMCC 440SP board, and I am having an issue with the asm includes u=
nder 2.6.17.9.  It seems that almost everything I try to compile is looking=
 for headers files in the asm-ppc directory that aren't there (like asm/err=
no.h, asm/ioctl.h, asm/types.h, asm/posix-types.h, etc.).  Where are these =
files?  I have a few applications that compiled fine under 2.4 that now won=
't compile under 2.6.=0A=0AThanks,=0A   Jeff Stevens=0A=0A=0A=0A
