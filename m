Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0C921DDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Sep 2008 07:51:01 +1000 (EST)
Subject: Re: [patch 1/1] powerpc: convert CONFIG_PPC_MERGE to CONFIG_PPC
	for legacy io checks
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <200809222141.m8MLfVHX031273@imap1.linux-foundation.org>
References: <200809222141.m8MLfVHX031273@imap1.linux-foundation.org>
Content-Type: text/plain
Date: Tue, 23 Sep 2008 07:50:22 +1000
Message-Id: <1222120222.12085.46.camel@pasglop>
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

On Mon, 2008-09-22 at 14:41 -0700, akpm@linux-foundation.org wrote:
> From: Kumar Gala <galak@kernel.crashing.org>
> 
> Now that arch/ppc is dead CONFIG_PPC_MERGE is always defined for all
> powerpc platforms and we want to get rid of CONFIG_PPC_MERGE use
> CONFIG_PPC instead.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> Cc: Paul Mackerras <paulus@samba.org>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
