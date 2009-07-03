Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 964EAB7080
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Jul 2009 20:06:47 +1000 (EST)
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1C641DDD0C
	for <linuxppc-dev@ozlabs.org>; Fri,  3 Jul 2009 20:06:47 +1000 (EST)
Date: Fri, 3 Jul 2009 10:59:37 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/2] ASoC: Fix mpc5200-psc-ac97 to ensure the data
	ready bit is cleared
Message-ID: <20090703095936.GA14330@rakim.wolfsonmicro.main>
References: <20090702175719.15773.58956.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090702175719.15773.58956.stgit@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 02, 2009 at 11:57:19AM -0600, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> When doing register reads, it is possible for there to be a stale
> data ready bit set which will cause subsequent reads to return
> prematurely with incorrect data.  This patch fixes the issues by
> ensuring stale data is cleared before starting another transaction.

Applied both, thanks.
