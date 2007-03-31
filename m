Return-Path: <SRS0+ab4c384dcbfc503e0951+1315+infradead.org+dwmw2@canuck.srs.infradead.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: David Woodhouse <dwmw2@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1175380464.6805.1.camel@localhost.localdomain>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<460D4BC3.8030805@am.sony.com>
	<1175276728.3122.161.camel@pmac.infradead.org>
	<3f028c6d87efaadfadee6894656ff220@kernel.crashing.org>
	<1175278427.3122.164.camel@pmac.infradead.org>
	<88b09b41faaba7e39189bbaf5b61acc3@kernel.crashing.org>
	<1175380464.6805.1.camel@localhost.localdomain>
Content-Type: text/plain
Date: Sat, 31 Mar 2007 23:42:54 +0100
Message-Id: <1175380974.3122.289.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2007-04-01 at 08:34 +1000, Benjamin Herrenschmidt wrote:
> In that specific case, I beleive it's fair enough to do the fixup in
> the kernel for a couple of reasons. One is that can be kept fairly
> self contained in the ps3 code (by resetting the LMB available ranges)
> and the other is that not doing so would make the existing bootloader
> unable to boot new kernels, which is annoying.

Almost as annoying as the fact that a _new_ bootloader built with the
current kernel isn't actually able to boot anything at all :)

SLOF, anyone? :)

-- 
dwmw2
