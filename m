MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: breakpoints cause oops
Date: Tue, 2 Mar 2004 14:23:39 -0600
Message-ID: <DCEAAC0833DD314AB0B58112AD99B93B06DA82@ismail.innsys.innovsys.com>
From: "Rune Torgersen" <runet@innovsys.com>
To: "Shawn Jin" <shawnxtech@yahoo.com>,
	<linuxppc-embedded@lists.linuxppc.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi
Anybody seen this error?
I'm getting it while trying to compile 2.6.2 for a 8266 based board,
using the ELDK 3.0 toolchain
(ppc_82xx-gcc v 3.2.2 & ppc_82xx-as ver 2.13.90.0.18 )

arch/ppc/kernel/head.S:1660: Error: unsupported relocation against MSR_

Caused by the following line:
	li	r5, MSR_		(in function m8260_gorom)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
