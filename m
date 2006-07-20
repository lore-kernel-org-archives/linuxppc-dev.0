Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17599.43337.775125.837876@cargo.ozlabs.ibm.com>
Date: Fri, 21 Jul 2006 02:03:21 +1000
From: Paul Mackerras <paulus@samba.org>
To: Horms <horms@verge.net.au>
Subject: Re: [PATCH] panic_on_oops: remove ssleep()
In-Reply-To: <31687.FP.7244@verge.net.au>
References: <31687.FP.7244@verge.net.au>
Cc: Andrew Morton <akpm@osdl.org>, Chris Zankel <chris@zankel.net>,
	Tony Luck <tony.luck@intel.com>, linux-ia64@vger.kernel.org,
	discuss@x86-64.org, Andi Kleen <ak@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Anton Blanchard <anton@samba.org>, Russell King <rmk@arm.linux.org.uk>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Horms writes:

> This patch is part of an effort to unify the panic_on_oops behaviour
> across all architectures that implement it.

Acked-by: Paul Mackerras <paulus@samba.org>
