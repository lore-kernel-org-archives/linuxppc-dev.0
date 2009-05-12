Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 5017FDDFE2
	for <linuxppc-dev@ozlabs.org>; Wed, 13 May 2009 08:15:45 +1000 (EST)
Date: Tue, 12 May 2009 15:11:12 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Li Yang <leoli@freescale.com>
Subject: Re: [PATCH 5/6] rio: warn_unused_result warnings fix
Message-Id: <20090512151112.7e2a3e74.akpm@linux-foundation.org>
In-Reply-To: <1242117363-14949-5-git-send-email-leoli@freescale.com>
References: <1242117363-14949-1-git-send-email-leoli@freescale.com>
	<1242117363-14949-2-git-send-email-leoli@freescale.com>
	<1242117363-14949-3-git-send-email-leoli@freescale.com>
	<1242117363-14949-4-git-send-email-leoli@freescale.com>
	<1242117363-14949-5-git-send-email-leoli@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, leoli@freescale.com, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 12 May 2009 16:36:02 +0800
Li Yang <leoli@freescale.com> wrote:

> +	if (rswitch) {
> +		if (rswitch->route_table)

this `if' is unneeded.

> +			kfree(rswitch->route_table);
> +		kfree(rswitch);
> +	}
