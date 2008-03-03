Return-Path: <hch@lst.de>
Date: Mon, 3 Mar 2008 05:18:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [Cbe-oss-dev] [PATCH 1/1] Cell RAS: Remove DEBUG,
	and add license and copyright
Message-ID: <20080303041856.GA22960@lst.de>
References: <10067109ffe9bc3c9a1357e5b8465ed1ebf114f9.1202956445.git.michael@ellerman.id.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10067109ffe9bc3c9a1357e5b8465ed1ebf114f9.1202956445.git.michael@ellerman.id.au>
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 14, 2008 at 01:34:17PM +1100, Michael Ellerman wrote:
> arch/powerpc/platforms/cell/ras.c still has DEBUG #defined, which is no
> longer neccessary. Disable it, this disables to pr_debugs().

No need to undef it, it's undefined by default.  Otherwise the patch
looks fine to me.
