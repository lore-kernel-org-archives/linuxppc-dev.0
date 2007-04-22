Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-12.arcor-online.net (mail-in-12.arcor-online.net
	[151.189.21.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6B69EDDEDA
	for <linuxppc-dev@ozlabs.org>; Sun, 22 Apr 2007 17:06:31 +1000 (EST)
In-Reply-To: <e4520bd4be50f2884003a9421863627c@bga.com>
References: <20070419073556.73A6BDDE4A@ozlabs.org>
	<e4520bd4be50f2884003a9421863627c@bga.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca8197808a747b83c14461f6fec375db@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 7/7] MPIC MSI backend
Date: Sun, 22 Apr 2007 09:06:15 +0200
To: Milton Miller <miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, linux-pci <linux-pci@atrey.karlin.mff.cuni.cz>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> Index: msi-new/arch/powerpc/sysdev/mpic_htmsi.c
>
> I just stumbled across drivers/pci/htirq.c, is that of any use?

That file deals with setting up HT APICs.  On all
current PowerPC systems with HT this is done (and
done correctly) by the firmware; there is no reason
to change any of it in the kernel.

mpic_htmsi deals with MSIs that come in over hypertransport
to the MPIC on CPC925/CPC945; this has nothing to
do with HT APICs.


Segher
