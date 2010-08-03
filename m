Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6786DB70DB
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 15:57:50 +1000 (EST)
Date: Tue, 3 Aug 2010 06:52:17 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 0/2 v3] mpc5200 ac97 gpio reset
Message-ID: <20100803055216.GA25306@rakim.wolfsonmicro.main>
References: <1276617907-10862-1-git-send-email-emillbrandt@dekaresearch.com>
	<20100622230026.GA2453@opensource.wolfsonmicro.com>
	<AANLkTiluyeGSwVSXgTeRxS3hVWTe3Gkn8qHrqbHJFMun@mail.gmail.com>
	<D37786F8-EBA7-4E55-AE83-5D0ABF1E17BF@opensource.wolfsonmicro.com>
	<AANLkTikbHp18uc-idFtEqakoo_0Vdg_rU44xv9uHwkvG@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTikbHp18uc-idFtEqakoo_0Vdg_rU44xv9uHwkvG@mail.gmail.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	Eric Millbrandt <emillbrandt@dekaresearch.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 31, 2010 at 10:42:15PM -0600, Grant Likely wrote:
> On Sun, Jun 27, 2010 at 4:01 PM, Mark Brown

> > I'm a little concerned with a collision with multi codec here. It'd
> > be handy if you could keep it separate in case it needs merging
> > into both trees (or we could merge via ASoC only).

> Hmmm.  Yeah, probably better to take it via your tree then.  I've
> currently got patch 1 in linux-next, but I'll drop it before asking
> benh to pull.  Go ahead and add my acked-by.

Looks like multi-component is slightly too late for .36 and I don't have
the original patch any more since it looked like you were going to be
carrying it...  could you restore the patch to your tree please?
