Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8BA68B6ED0
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 11:40:24 +1100 (EST)
Date: Fri, 9 Mar 2012 00:39:37 +0000
From: Russell King <rmk@arm.linux.org.uk>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: linux-next: manual merge of the powerpc tree with the arm tree
Message-ID: <20120309003937.GC8680@flint.arm.linux.org.uk>
References: <20120308120422.e071cba36425eacbee1f8d98@canb.auug.org.au>
 <25744.1331174036@neuling.org>
 <20120308145131.fad50bbc79c36f0b0b12d101@canb.auug.org.au>
 <1331185951.3105.29.camel@pasglop> <1331249746.3105.40.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1331249746.3105.40.camel@pasglop>
Sender: Russell King <rmk@arm.linux.org.uk>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
 Michael Neuling <mikey@neuling.org>, linux-kernel@vger.kernel.org,
 Rob Herring <rob.herring@calxeda.com>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Mar 09, 2012 at 10:35:46AM +1100, Benjamin Herrenschmidt wrote:
> Actually, I didn't keep MAY_HAVE_SPARSE_IRQ, I kept HAVE_SPARSE_IRQ. If
> I remove it, then I get Kconfig warnings:
> 
> warning: (PPC) selects SPARSE_IRQ which has unmet direct dependencies
> (HAVE_GENERIC_HARDIRQS && HAVE_SPARSE_IRQ)

Do you have commit 2ed86b16eabe4efbf80cc725a8cbb5310746a2fc ?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:
