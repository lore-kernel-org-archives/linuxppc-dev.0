Return-Path: <linux@dominikbrodowski.net>
Received: from linta.de (isilmar.linta.de [213.133.102.198])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 98BF9DE108
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Jul 2008 07:16:25 +1000 (EST)
Date: Thu, 10 Jul 2008 23:16:13 +0200
From: Dominik Brodowski <linux@dominikbrodowski.net>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: powerpc/cell/cpufreq: add spu aware cpufreq governor
Message-ID: <20080710211613.GA7868@isilmar.linta.de>
References: <200807071702.31240.arnd@arndb.de>
	<20080708152728.GF4997@codemonkey.org.uk>
	<20080710180553.GB13890@isilmar.linta.de>
	<200807102305.08752.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200807102305.08752.arnd@arndb.de>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>,
	Dave Jones <davej@codemonkey.org.uk>, cpufreq@lists.linux.org.uk,
	linuxppc-dev@ozlabs.org, Jeremy Kerr <jk@ozlabs.org>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jul 10, 2008 at 11:05:08PM +0200, Arnd Bergmann wrote:
> On Thursday 10 July 2008, Dominik Brodowski wrote:
> > Actually, "cpufreq-set -g spu_governor" should be enough. (BTW, do we really
> > want this name?)
> 
> Do you have a better suggestion for the name? I don't think there was a
> particularly strong reason to choose it over something else.

The issue I was pondering is whether to include "governor" in the name, for
we do not do this for the other governors. So here are my suggestions :)

	spu
	spuload
	spudemand

Best,
	Dominik
