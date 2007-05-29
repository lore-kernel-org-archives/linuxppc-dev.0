Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2ADFEDE027
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:13:21 +1000 (EST)
Subject: Re: [PATCH 1/5] Remove the errata fix codes for MPC8641 silicon
	ver 1.0 which is end of life.
From: Jon Loeliger <jdl@freescale.com>
To: Wei Zhang <Wei.Zhang@freescale.com>
In-Reply-To: <11798051101543-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Message-Id: <1180462396.13106.32.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:13:16 -0500
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
> Remove the errata fix codes for MPC8641 silicon ver 1.0 which
> is end of life.
> 
> The MPC8641 silicon ver 1.0 is not fully support PCI/PCI Express
> specifications. The revision 2.0 fixes all of these errata
> and the rev 1.0 silicon is end of life. So errata codes are removed.
> 
> Now, The chip is full compatible with PCI/PCI Express
> specifications. The generic PCI code is used.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Acked-by: Roy Zang <tie-fei.zang@freescale.com>

Acked-by: Andy Fleming <afleming@freescale.com>
Acked-by: Jon Loeliger <jdl@freescale.com>
