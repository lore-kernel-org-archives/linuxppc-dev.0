Return-Path: <glikely@secretlab.ca>
Received: from mail-yw0-f51.google.com (mail-yw0-f51.google.com
	[209.85.213.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 95D94B71F7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Mar 2011 15:39:06 +1100 (EST)
Received: by ywg4 with SMTP id 4so2208120ywg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 07 Mar 2011 20:39:03 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Mon, 7 Mar 2011 21:38:58 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Lennert Buytenhek <buytenh@wantstofly.org>
Subject: Re: [PATCH 28/28] powerpc: Enable GENERIC_HARDIRQS_NO_DEPRECATED.
Message-ID: <20110308043858.GC23260@angua.secretlab.ca>
References: <cover.1299541392.git.buytenh@wantstofly.org>
	<20110308000023.GG16649@mail.wantstofly.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110308000023.GG16649@mail.wantstofly.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
	Stephen Rothwell <sfr@canb.auug.org.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 08, 2011 at 01:00:23AM +0100, Lennert Buytenhek wrote:
> Signed-off-by: Lennert Buytenhek <buytenh@secretlab.ca>

All 28 look good to me, it compiles with all the defconfigs I tried,
and it boots on mpc5200.  Feel free to add:

Acked-by: Grant Likely <grant.likely@secretlab.ca>

Ben, I've got this series applied against 2.6.38-rc7 in a branch on my
private repo.  If you want me to I can push it out to my powerpc/next
branch so that it gets some linux-next exposure.

g.

> ---
>  arch/powerpc/Kconfig |    1 +
>  1 files changed, 1 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 7d69e9b..71ba047 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -134,6 +134,7 @@ config PPC
>  	select HAVE_GENERIC_HARDIRQS
>  	select HAVE_SPARSE_IRQ
>  	select IRQ_PER_CPU
> +	select GENERIC_HARDIRQS_NO_DEPRECATED
>  
>  config EARLY_PRINTK
>  	bool
> -- 
> 1.7.4
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
