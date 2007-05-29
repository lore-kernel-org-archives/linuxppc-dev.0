Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2976DE084
	for <linuxppc-dev@ozlabs.org>; Wed, 30 May 2007 04:15:18 +1000 (EST)
Subject: Re: [PATCH 4/5] Set RC of mpc8641 to transparent bridge for
	transfer legacy I/O access.
From: Jon Loeliger <jdl@freescale.com>
To: Wei Zhang <Wei.Zhang@freescale.com>
In-Reply-To: <11798051102051-git-send-email-wei.zhang@freescale.com>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<11798051102051-git-send-email-wei.zhang@freescale.com>
Content-Type: text/plain
Message-Id: <1180462512.13106.38.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Tue, 29 May 2007 13:15:12 -0500
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
> Set RC of mpc8641 to transparent bridge for transfer legacy I/O access.
> Now, the children bus could use the I/O resource of the host bridge.
> 
> Note: The 0x7010 is the device ID of host bridge for MPC8641 and
> 0x7011 is the device ID of host bridge fro MPC8641D.
> 
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>

Acked-by: Andy Fleming <afleming@freescale.com>
Acked-by: Jon Loeliger <jdl@freescale.com>
