Message-ID: <40D4B1AF.3070209@pobox.com>
Date: Sat, 19 Jun 2004 17:35:43 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Pantelis Antoniou <panto@intracom.gr>
Cc: Tom Rini <trini@kernel.crashing.org>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [PATCH] fec_8xx driver take 2 (+ethtool)
References: <40CD902A.4020702@intracom.gr>
In-Reply-To: <40CD902A.4020702@intracom.gr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Your patch is acceptable and OK to apply, but time has moved forward and
there is a trivial rejection:

[jgarzik@sata fec]$ BK_USER=panto BK_HOST=intracom.gr bk import -tpatch
-CR "-y[netdrvr] add fec_8xx driver" ~/tmp/patch .
Patching...
Patch failed.  **** patch log follows ****
Patching file drivers/net/Kconfig
Patching file drivers/net/Makefile
Creating file drivers/net/fec_8xx/Kconfig
Creating file drivers/net/fec_8xx/Makefile
Creating file drivers/net/fec_8xx/fec_8xx-netta.c
Creating file drivers/net/fec_8xx/fec_8xx.h
Creating file drivers/net/fec_8xx/fec_main.c
Creating file drivers/net/fec_8xx/fec_mii.c
Patching file include/asm-ppc/8xx_immap.h
1 out of 1 hunk FAILED -- saving rejects to file
include/asm-ppc/8xx_immap.h.rej


Please resubmit TWO emails, one with fec_8xx patch, and another with
ethtool patch.

See Documentation/SubmittingPatches for more info.

	Jeff


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
