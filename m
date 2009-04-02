Return-Path: <kyle@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org [18.85.46.34])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 13B74DDD1B
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Apr 2009 09:09:52 +1100 (EST)
Date: Thu, 2 Apr 2009 18:09:47 -0400
From: Kyle McMartin <kyle@mcmartin.ca>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC][PATCH] powerpc: Emulate enough of SPE instructions to
	make gcc happy
Message-ID: <20090402220947.GG14159@bombadil.infradead.org>
References: <1238709887-26237-1-git-send-email-galak@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1238709887-26237-1-git-send-email-galak@kernel.crashing.org>
Sender: Kyle McMartin <kyle@infradead.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 02, 2009 at 05:04:47PM -0500, Kumar Gala wrote:
> +config SPE_EMULATION
> +	bool "SPE Emulation Support"
> +	depends on (CLASSIC32 || POWER4) && !ALTIVEC && !SPE
> +	---help---
> +	  This option enables kernel support for the Altivec extensions to the
> +

Looks like you kind of trailed off here... :)

cheers, Kyle
