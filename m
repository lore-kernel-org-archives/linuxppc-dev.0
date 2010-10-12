Return-Path: <B07421@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
	[65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8F06FB70CB
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 04:33:51 +1100 (EST)
Received: from mail39-tx2 (localhost.localdomain [127.0.0.1])	by
	mail39-tx2-R.bigfish.com (Postfix) with ESMTP id C62B9302D2	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 17:33:47 +0000 (UTC)
Received: from TX2EHSMHS040.bigfish.com (unknown [10.9.14.247])	by
	mail39-tx2.bigfish.com (Postfix) with ESMTP id 77D554F0075	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 17:33:14 +0000 (UTC)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw01.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9CHXBYd016871	for
	<linuxppc-dev@ozlabs.org>; Tue, 12 Oct 2010 10:33:11 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	o9CHmIF5017585	for <linuxppc-dev@ozlabs.org>;
	Tue, 12 Oct 2010 12:48:19 -0500 (CDT)
Date: Tue, 12 Oct 2010 12:33:08 -0500
From: Scott Wood <scottwood@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/fsl-booke: Add support for FSL 64-bit e5500
	core
Message-ID: <20101012123308.57a59830@udp111988uds.am.freescale.net>
In-Reply-To: <1286898653-2266-1-git-send-email-galak@kernel.crashing.org>
References: <1286898653-2266-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 12 Oct 2010 10:50:52 -0500
Kumar Gala <galak@kernel.crashing.org> wrote:

> The new e5500 core is similar to the e500mc core but adds 64-bit
> support.  We support running it in 32-bit mode as it is identical to the
> e500mc.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Updated to remove CONFIG_PPC_E5500 and use E500MC

It still has E500 || E500MC all over the place...

If E500MC is not going to imply E500 that should be consistent for both
32 and 64 bit -- though I think it would make more sense that E500MC
does imply E500.

-Scott
