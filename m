Return-Path: <hch@lst.de>
Date: Mon, 10 Jan 2005 17:39:15 +0100
From: Christoph Hellwig <hch@lst.de>
To: Tom Rini <trini@kernel.crashing.org>
Message-ID: <20050110163914.GA11906@lst.de>
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
	<20050110145219.GB2226@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050110145219.GB2226@smtp.west.cox.net>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 10, 2005 at 07:52:19AM -0700, Tom Rini wrote:
> +# PPC_PREP can be set to y on a PPC970 configuration, which isn't a real
> +# machine.

Maybe we should prevent setting PPC_PREP to y for PPC970 instead?
