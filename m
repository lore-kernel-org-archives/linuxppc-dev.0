Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6A630DE052
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Jul 2008 17:37:21 +1000 (EST)
Message-Id: <B953B5BE-BB24-4656-9F13-7A8228D893E3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Nye Liu <nyet@mrv.com>
In-Reply-To: <20080627200100.GA16661@mrv.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] POWERPC CPM: Minor cosmetic changes to udbg_putc
Date: Wed, 2 Jul 2008 02:37:09 -0500
References: <20080627200100.GA16661@mrv.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 27, 2008, at 3:01 PM, Nye Liu wrote:

> From: Nye Liu <nyet@mrv.com>
>
> udbg_putc is a *function pointer* that is initialized during
> udbg_init_cpm. It might not be initialized properly when called from
> udbg_putc_cpm(), so (recursively) call udbg_putc_cpm() directly.
>
> Printing an "X" on initialization is ugly. How about a "\n" instead?
>
> Signed-off-by: Nye Liu <nyet@mrv.com>
>
> ---

Applied.  I removed the "\n" per Scott's feedback.

- k
