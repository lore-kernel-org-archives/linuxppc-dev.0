Return-Path: <PeterHuewe@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
 (Client CN "mout.gmx.net", Issuer "TeleSec ServerPass DE-1" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 612C62C008F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Oct 2013 09:07:59 +1100 (EST)
Received: from lamerx.localnet ([84.56.48.17]) by mail.gmx.com (mrgmx001)
 with ESMTPSA (Nemesis) id 0MLvGW-1Vbet00O7A-007oJr for
 <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Oct 2013 23:02:46 +0100
From: Peter =?iso-8859-1?q?H=FCwe?= <PeterHuewe@gmx.de>
To: linuxppc-dev@lists.ozlabs.org,
 tpmdd-devel@lists.sourceforge.net
Subject: Has anyone a ATMEL TPM Chip on PPC64 (CONFIG_TCG_ATMEL)?
Date: Sun, 27 Oct 2013 23:06:09 +0100
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="us-ascii"
Message-Id: <201310272306.09310.PeterHuewe@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

I was wondering if anyone here on this list still has a machine with an old=
=20
ATMEL TPM (trusted platform module) lying around?

=46rom the kconfig entry it becomes evident that it was only supported on p=
pc64=20
machines.

config TCG_ATMEL
	tristate "Atmel TPM Interface"
	depends on PPC64 || HAS_IOPORT
	---help---
	  If you have a TPM security chip from Atmel say Yes and it=20
	  will be accessible from within Linux.  To compile this driver=20
	  as a module, choose M here; the module will be called tpm_atmel.

The hardware/driver is pretty old and the driver might have contained a bug=
=20
that made it unusable for the last 6 years ;)

So if anyone still has this kind of hardware around, please reply.

Thanks,
Peter
