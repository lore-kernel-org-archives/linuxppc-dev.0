Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <9CFB9DA5261CD611A29B00508B78904807F880ED@ex-deu-munich02.force.de>
From: "Demke, Torsten" <Torsten.Demke@fci.com>
To: "Linuxppc-Embedded (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: problem with standard libc on 8xx
Date: Fri, 27 Feb 2004 09:55:12 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello all,

I created my own root-fs for a MPC8xx platform
using standard Debian packages (including libc).
When I start the system, the init scripts hangs
whenever it executes a function (exceptt some simple
thinks like 'echo').
- the same root-fs starts without problem on a MPC8245 platform.
- the root-fs starts when I exchange the libc with the libraries
from the ELDK.

I guess that the Debian libc uses floating point - which
is not available on MPC8xx - but I thougt the kernel would
emulate this calls (CONFIG_MATH_EMULATION=y).

Any hints?

Regards,
Torsten

  Torsten Demke
  Software Engineer
  Force Computers GmbH
  - A Solectron Company -
  Lilienthalstr. 15
  D-85579 Neubiberg/München
  Tel. ++49/89/60814-404
  Fax ++49/89/60814-112
  mailto:torsten.demke@fci.com
  www.forcecomputers.com


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
