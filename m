Return-Path: <mingo@elte.hu>
Received: from fallback.mail.elte.hu (fallback.mail.elte.hu [157.181.151.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 098EFDE111
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 22:14:47 +1100 (EST)
Received: from mx2.mail.elte.hu ([157.181.151.9])
	by fallback.mail.elte.hu with esmtp (Exim) id 1LMIGB-00007x-Dn
	from <mingo@elte.hu>
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jan 2009 09:34:59 +0100
Date: Mon, 12 Jan 2009 09:34:12 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix cpufreq drivers after cpufreq core changes
Message-ID: <20090112083412.GB19701@elte.hu>
References: <20090112104837.69feedec.sfr@canb.auug.org.au>
	<1231719015.22571.4.camel@pasglop>
	<1231719721.22571.9.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1231719721.22571.9.camel@pasglop>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, arndb <arndb@arndb.de>,
	Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
	Mike Travis <travis@sgi.com>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Olof Johansson <olof@lixom.net>, Andrew Morton <akpm@linux-foundation.org>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	"David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


* Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> This updates the cpufreq drivers in arch/powerpc so they build again
> after the core cpufreq changes that broke them in commit
> in835481d9bcd65720b473db6b38746a74a3964218.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> Tested on a G5. Olof, Arnd, any chance you can test the cell and pasemi
> drivers still work ?
> 
> Linus, you can probably merge this now to fix the build problems.

Thanks Ben!

The powerpc defconfig built fine - you might wan to turn on cpufreq in the 
powerpc defconfig so that cross-build tests can catch problems like this.

	Ingo
