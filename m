Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 68F25B71BE
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 13:17:12 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B77C7DDD0B
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Jun 2009 13:17:11 +1000 (EST)
Subject: Re: linux-next: powerpc tree build warning
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20090611113930.78a42893.sfr@canb.auug.org.au>
References: <20090611113930.78a42893.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Thu, 11 Jun 2009 13:14:04 +1000
Message-Id: <1244690044.5739.31.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, linux-next@vger.kernel.org,
	Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-06-11 at 11:39 +1000, Stephen Rothwell wrote:
> Hi Ben,
> 
> Today's linux-next build (powerpc ppc64_defconfig) produced this warning:
> 
> arch/powerpc/platforms/Kconfig.cputype:60:warning: defaults for choice values not supported
> 
> We appear to have CONFIG_PPC_BOOK3S int two places which is confusing
> Kconfig.

Yes, I see that. One place depends on PPC32 and the other one PPC64, but
it still seems to be somewhat confused. In any case, it seems to still
do the right thing, so not a big hurry here, but I'll do a patch that
does it differently.

Cheers,
Ben.
