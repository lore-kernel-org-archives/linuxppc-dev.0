Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A532CDDDF5
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 13:05:56 +1000 (EST)
Received: from localhost (localhost [127.0.0.1] (may be forged))
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id l4A1GMi8013789
	for <linuxppc-dev@ozlabs.org>; Wed, 9 May 2007 21:16:22 -0400
From: Rob Landley <rob@landley.net>
To: linuxppc-dev@ozlabs.org
Subject: Building ppc/powerpc kernel to run under QEMU.
Date: Wed, 9 May 2007 22:03:25 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705092203.26042.rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I've been puttering around with my Firmware Linux project trying to add
powerpc as a supported platform.  I can build kernels that qemu can boot (such
as a "prep" kernel) using ARCH=ppc, but that one doesn't support make
headers_install.

Using ARCH=powerpc makes headers_install work, but there's no kernel .config 
I've been able to come up with that generates a kernel I can boot under qemu.

I could add a special case to my build script, but so far I've got it building 
eight targets (x86, x86-64, mips, mipsel, armv4l, armv5l, and sparc) with the 
same ARCH= for headers_install and the actual kernel compile.  It seems there 
_should_ be a way to do this for as prominent an architecture as PowerPC.

I was told this was the right place to ask: what's the status of the 
ppc->powerpc migration, and is there any known way to get ARCH=powerpc to 
build a kernel qemu can boot?

Rob
