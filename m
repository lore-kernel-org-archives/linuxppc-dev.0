Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id D8FAEDDE45
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Mar 2007 04:15:58 +1100 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l29HFtDp001130
	for <linuxppc-dev@ozlabs.org>; Fri, 9 Mar 2007 10:15:55 -0700 (MST)
Subject: RE: [PATCH] Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
From: Jon Loeliger <jdl@freescale.com>
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
In-Reply-To: <7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A11@zch01exm23.fsl.freescale.net>
References: <1173300525.23776.136.camel@ld0161-tx32>
	<7EA18FDD2DC2154AA3BD6D2F22A62A0E5F6A11@zch01exm23.fsl.freescale.net>
Content-Type: text/plain
Message-Id: <1173460554.23776.232.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Fri, 09 Mar 2007 11:15:54 -0600
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-03-08 at 21:32, Zang Roy-r61911 wrote:
> > This move sets the stage for the use of generic PCI Express 
> > code in 85xx and 86xx parts from FSL.  Subsequent patches for 
> > 8548 and 8544 will be able to use this shared code.


> How about 8548 with pcie?
> Roy

Roy,

This patch that I released was a very simple
effort to _begin_ the migration of PCI-Ex out
of 8641 into a generic place so that we can
get your patches accepted more readily.

This first step simply _moved_ the existing file
out of 8641 and patched up the CONFIG options so
that 8641 will still work.  Notice that this does
not yet address the 85xx series boards at all.
Those patches (yours) will follow shortly.

We will need to resolve the problems with the
transparent bridges issue first, though.  I am
currently working through some of those issues
with Kumar.  We can add you to the discussion
there for sure!

jdl
