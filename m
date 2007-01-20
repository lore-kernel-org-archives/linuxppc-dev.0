Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id EC039DDE2D
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 21 Jan 2007 00:39:33 +1100 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.skekraft.net (Postfix) with ESMTP id 8AF86A4045
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 14:21:22 +0100 (CET)
Received: from mail.skekraft.net ([127.0.0.1])
	by localhost (ns.skekraft.net [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 00874-04 for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 14:21:22 +0100 (CET)
Received: from icd.localnet (78.net216.skekraft.net [84.244.216.78])
	by mail.skekraft.net (Postfix) with ESMTP id 013FAA4009
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 20 Jan 2007 14:21:21 +0100 (CET)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] # ppc: ppc4xx_set_src/dst_addr were only correct for DMA0
Date: Sat, 20 Jan 2007 14:21:19 +0100
References: <200701200002.32078.niklaus.giger@member.fsf.org>
In-Reply-To: <200701200002.32078.niklaus.giger@member.fsf.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200701201421.19850.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Saturday 20 January 2007 00:02, Niklaus Giger wrote:
> DCRN_DMASAH0 + dmanr*2
to
> DCRN_DMASAH0 + dmanr * 0x8

Wouln't it be possible to give DCRN_DMASAH0 such an type that
DCRN_DMASAH0 + dmanr
would do? Or even better
DCRN_DMASAH[dmanr]

BTW this code looks suspicious, how will the 64BIT dma
ever work? Only highest 32 bits are stored...

PPC should really try to move toward the generic interface...

/RogerL
