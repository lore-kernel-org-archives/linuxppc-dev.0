Return-Path: <benh@kernel.crashing.org>
Subject: Re: [Cbe-oss-dev] [PATCH] Ignore memory listed in PS3 device tree
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <88b09b41faaba7e39189bbaf5b61acc3@kernel.crashing.org>
References: <1175208237.3122.78.camel@pmac.infradead.org>
	<460D4BC3.8030805@am.sony.com>
	<1175276728.3122.161.camel@pmac.infradead.org>
	<3f028c6d87efaadfadee6894656ff220@kernel.crashing.org>
	<1175278427.3122.164.camel@pmac.infradead.org>
	<88b09b41faaba7e39189bbaf5b61acc3@kernel.crashing.org>
Content-Type: text/plain
Date: Sun, 01 Apr 2007 08:34:24 +1000
Message-Id: <1175380464.6805.1.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, David Woodhouse <dwmw2@infradead.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 2007-03-31 at 17:27 +0200, Segher Boessenkool wrote:

> Yes, every single little addition isn't very big, sure.
> It all accumulates though and at some point it will be
> too much.  My tolerances are lower than yours I guess ;-)

In that specific case, I beleive it's fair enough to do the fixup in the
kernel for a couple of reasons. One is that can be kept fairly self
contained in the ps3 code (by resetting the LMB available ranges) and
the other is that not doing so would make the existing bootloader unable
to boot new kernels, which is annoying.

Ben.
