Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F869B70B3
	for <linuxppc-dev@lists.ozlabs.org>;
	Sun,  8 Nov 2009 06:33:24 +1100 (EST)
Date: Sat, 7 Nov 2009 19:33:18 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Message-ID: <20091107193318.GB31789@sirena.org.uk>
References: <20091107081631.18908.82921.stgit@angua>
	<20091107083448.18908.80366.stgit@angua>
	<20091107181153.GA31789@sirena.org.uk>
	<fa686aa40911071019y6be8283bu8d36d96420deefab@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40911071019y6be8283bu8d36d96420deefab@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH 6/6] ASoC/mpc5200: Add fudge factor to
	value reported by .pointer()
Cc: alsa-devel@alsa-project.org, linuxppc-dev@lists.ozlabs.org,
	lrg@slimlogic.co.uk
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Nov 07, 2009 at 11:19:54AM -0700, Grant Likely wrote:
> On Sat, Nov 7, 2009 at 11:11 AM, Mark Brown

> > It occurs to me that in terms of dealing with what's going on here this
> > probably is achieving exactly the same effect as Jon's code in that it
> > tells ALSA that things are a bit ahead of where the buffer started.

> Possibly, but I can both reproduce and eliminate the problem Jon is
> seeing regardless of whether or not this patch, so I'm not yet
> convinced.

That doesn't entirely surprise me; I'm not convinced that the original
approach entirely deals with the issue rather than just making it much
harder to see.
