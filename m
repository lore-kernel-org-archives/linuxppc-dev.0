Return-Path: <m_dalmas@yahoo.com.br>
Received: from web50302.mail.re2.yahoo.com (web50302.mail.re2.yahoo.com
	[206.190.38.56]) by ozlabs.org (Postfix) with SMTP id A377EDE347
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  2 Apr 2008 04:10:17 +1100 (EST)
Date: Tue, 1 Apr 2008 14:03:36 -0300 (ART)
From: Marcelo Dalmas <m_dalmas@yahoo.com.br>
Subject: mpc52xx_mmap_ctl access
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Message-ID: <132281.10315.qm@web50302.mail.re2.yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi all!

I'm updating a device driver from linux 2.6.16 ppc
tree to linux 2.6.24 powerpc in a lite5200 based
board.

I need to access  mpc52xx_mmap_ctl and mpc52xx_cslpc.

In ppc tree I do:

 mmap_ctl =
ioremap(MPC52xx_PA(MPC52xx_MMAP_CTL_OFFSET),
                     MPC52xx_MMAP_CTL_SIZE)

How can I access it in powerpc tree?


Thank you,

Marcelo Dalmas
 



      Abra sua conta no Yahoo! Mail, o único sem limite de espaço para armazenamento!
http://br.mail.yahoo.com/
