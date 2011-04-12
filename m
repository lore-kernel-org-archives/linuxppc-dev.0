Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DC294B6F16
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Apr 2011 14:35:41 +1000 (EST)
Subject: RE: Problem with mini-PCI-E slot on P2020RDB
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Aggrwal Poonam-B10812 <B10812@freescale.com>
In-Reply-To: <45903308677306428B6EE7E6FF5A520410B713@039-SN1MPN1-004.039d.mgd.msft.net>
References: <071A08F2C6A57E4E94D980ECA553F87417069A@039-SN1MPN1-004.039d.mgd.msft.net>
	<45903308677306428B6EE7E6FF5A520410B713@039-SN1MPN1-004.039d.mgd.msft.net>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 12 Apr 2011 14:35:20 +1000
Message-ID: <1302582920.28876.48.camel@pasglop>
Mime-Version: 1.0
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Felix Radensky <felix@embedded-sol.com>,
	Gupta Maneesh-B18878 <B18878@freescale.com>,
	Kushwaha Prabhakar-B32579 <B32579@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-04-12 at 04:05 +0000, Aggrwal Poonam-B10812 wrote:
> May be you can look at
> http://old.nabble.com/Problem-with-mini-PCI-E-slot-on-P2020RDB-td26802038.html
> 
> Felix we do not have the atheros driver for 2.6.38 and the issue is
> only seen with Atheros not sata_sil. If possible can you send the
> driver code if possible so that we can try reproducing it.

drivers/net/wireless/ath/* ? :-)

Cheers,
Ben.
