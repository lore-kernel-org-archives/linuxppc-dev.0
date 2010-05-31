Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 23727B7D68
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 31 May 2010 12:00:36 +1000 (EST)
Subject: Re: [PATCH] powerpc: Don't export cvt_fd & _df when CONFIG_PPC_FPU
	is not set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
In-Reply-To: <1275270628.1931.540.camel@pasglop>
References: <1275270628.1931.540.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 31 May 2010 12:00:31 +1000
Message-ID: <1275271231.1931.547.camel@pasglop>
Mime-Version: 1.0
Cc: Alexander Graf <agraf@suse.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2010-05-31 at 11:50 +1000, Benjamin Herrenschmidt wrote:
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/kernel/ppc_ksyms.c |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)

Alex, this is just a temporary fix to remove the build breakage for 40x
etc... but please, update KVM to just build-in its own.

Don't we have .o's that are always built into modules nowadays ?

Cheers,
Ben.
