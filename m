Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 1E9AC2C0087
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Dec 2012 10:21:37 +1100 (EST)
Message-ID: <1355267959.19932.40.camel@pasglop>
Subject: Re: linux-next: some merging notes
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 12 Dec 2012 10:19:19 +1100
In-Reply-To: <20121212091552.02c72c8926f9f9147b080d68@canb.auug.org.au>
References: <20121212091552.02c72c8926f9f9147b080d68@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: "N, Mugunthan V" <mugunthanvnm@ti.com>, Bill Pemberton <wfp5p@virginia.edu>,
 Arnd Bergmann <arnd@arndb.de>, Greg KH <greg@kroah.com>,
 linuxppc-dev@lists.ozlabs.org, Tomi Valkeinen <tomi.valkeinen@ti.com>,
 Rusty Russell <rusty@rustcorp.com.au>, LKML <linux-kernel@vger.kernel.org>,
 Steven Rostedt <srostedt@redhat.com>, linux-next@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, netdev@vger.kernel.org,
 Olof Johansson <olof@lixom.net>, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 Linus <torvalds@linux-foundation.org>, David Miller <davem@davemloft.net>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-12-12 at 09:15 +1100, Stephen Rothwell wrote:
> The powerpc tree
> (git://git.kernel.org/pub/scm/linux/kernel/git/benh/powerpc.git#next)
> contains a commit that breaks the building of
> lib/pSeries-reconfig-notifier-error-inject.c.  I applied a patch to
> linux-next to disable CONFIG_PSERIES_RECONFIG_NOTIFIER_ERROR_INJECT.

I will put a fix in before I send the pull request.

Cheers,
Ben.
