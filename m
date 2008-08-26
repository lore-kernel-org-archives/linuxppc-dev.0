Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E18F0DEE5D
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Aug 2008 14:39:35 +1000 (EST)
Subject: Re: [PATCH v2] powerpc: Fix determining TI_CPU in
	power_save_ppc32_restore()
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1219716536-21643-1-git-send-email-galak@kernel.crashing.org>
References: <1219716536-21643-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain
Date: Tue, 26 Aug 2008 14:39:28 +1000
Message-Id: <1219725568.13162.122.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-08-25 at 21:08 -0500, Kumar Gala wrote:
> The calculation to get TI_CPU based off of SPRG3 was just plain wrong.
> Just offset off the stack pointer (to get to thread_info) like all the
> other references to TI_CPU do.
> 
> This was pointed out by Chen Gong <G.Chen@freescale.com>
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
