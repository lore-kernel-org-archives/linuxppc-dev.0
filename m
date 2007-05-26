Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 282F1DDECC
	for <linuxppc-dev@ozlabs.org>; Sat, 26 May 2007 12:38:54 +1000 (EST)
Received: from localhost (localhost [127.0.0.1] (may be forged))
	by grelber.thyrsus.com (8.13.4/8.13.4) with ESMTP id l4Q1qp9D009212
	for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2007 21:52:51 -0400
From: Rob Landley <rob@landley.net>
To: linuxppc-dev@ozlabs.org
Subject: Porting "prep" from ppc to powerpc.
Date: Fri, 25 May 2007 22:38:39 -0400
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200705252238.39819.rob@landley.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Is anyone already doing this?  I asked around here a few weeks ago and got the 
advice:

> In theory.. copy the files from ppc/platforms/prep.* to
> powerpc/platforms/prep/ 
> and make some Kconfigs and see what breaks :)

Unfortunately, there isn't a ppc/platforms/prep.  Under arch/ppc there's:

./boot/simple/misc-prep.c
./boot/simple/prepmap.c
./boot/utils/mkprep.c
./configs/prep_defconfig
./platforms/prep_pci.c
./platforms/prep_setup.c
./syslib/prep_nvram.c

And I'm not sure which are relevant.  Any hints?

Rob
