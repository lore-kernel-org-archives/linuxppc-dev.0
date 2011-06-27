Return-Path: <B11780@freescale.com>
Received: from CH1EHSOBE017.bigfish.com (ch1ehsobe001.messaging.microsoft.com
	[216.32.181.181]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8ECE8B6F6F
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 23:35:13 +1000 (EST)
Received: from mail74-ch1 (localhost.localdomain [127.0.0.1])	by
	mail74-ch1-R.bigfish.com (Postfix) with ESMTP id 3B7DE1BE00F6	for
	<linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2011 13:35:10 +0000 (UTC)
Received: from CH1EHSMHS023.bigfish.com (snatpool1.int.messaging.microsoft.com
	[10.43.68.253])	by mail74-ch1.bigfish.com (Postfix) with ESMTP id
	F1BCE1188051	for <linuxppc-dev@ozlabs.org>;
	Mon, 27 Jun 2011 13:35:09 +0000 (UTC)
Subject: Re: [PATCH] powerpc/85xx: disable timebase synchronization under the
	hypervisor
MIME-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset="us-ascii"
From: Kumar Gala <kumar.gala@freescale.com>
In-Reply-To: <1308092673-13045-1-git-send-email-timur@freescale.com>
Date: Mon, 27 Jun 2011 08:35:07 -0500
Message-ID: <EE100AF8-3C64-4774-A717-0279057D94D5@freescale.com>
References: <1308092673-13045-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: scottwood@freescale.com, B29882@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 14, 2011, at 6:04 PM, Timur Tabi wrote:

> The Freescale hypervisor does not allow guests to write to the timebase
> registers (virtualizing the timebase register was deemed too complicated),
> so don't try to synchronize the timebase registers when we're running
> under the hypervisor.
> 
> This typically happens when kexec support is enabled.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/platforms/85xx/p3041_ds.c |   11 +++++++++++
> arch/powerpc/platforms/85xx/p4080_ds.c |   11 +++++++++++
> arch/powerpc/platforms/85xx/p5020_ds.c |   11 +++++++++++
> 3 files changed, 33 insertions(+), 0 deletions(-)

applied to next

- K
