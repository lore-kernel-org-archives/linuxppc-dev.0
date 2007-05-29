Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 1FFAADE0A0
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:14:53 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Jon Loeliger <jdl@freescale.com>
To: Wei Zhang <Wei.Zhang@freescale.com>
In-Reply-To: <1179805110278-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Message-Id: <1180462487.13106.36.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:14:47 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-05-21 at 22:38, Zhang Wei wrote:
> Float the pci bus number on MPC8641HPCN board.
> For example, PCI hose 1 bus range is from 0 to 2, the PCI hose 2 bus
> range will start from 3.
> Add the pci-express link training stats check. It avoid the system halt
> while the link training is fault.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Acked-by: Roy Zang <tie-fei.zang@freescale.com>
> ---

Acked-by: Andy Fleming <afleming@freescale.com>
Acked-by: Jon Loeliger <jdl@freescale.com>
