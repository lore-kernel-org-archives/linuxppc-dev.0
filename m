Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 87C1ADDFE2
	for <linuxppc-dev@ozlabs.org>; Wed, 27 May 2009 00:53:32 +1000 (EST)
Date: Tue, 26 May 2009 15:53:24 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH V5 1/5] powerpc: introduce macro
	spin_event_timeout()
Message-ID: <20090526145324.GF8969@sirena.org.uk>
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123406.17472.79948.stgit@terra>
	<20090526130301.GE8969@sirena.org.uk>
	<9e4733910905260612v40a70ad8haeb4c916a1a758b5@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910905260612v40a70ad8haeb4c916a1a758b5@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 09:12:10AM -0400, Jon Smirl wrote:
> On Tue, May 26, 2009 at 9:03 AM, Mark Brown

> > As previously mentioned you need to submit any changes you want to make
> > here as incremental patches against the PowerPC tree rather than as an
> > entire new patch. ?If you are forwarding on copies of the patch you
> > really ought to preserve Timur's authorship too with a From line in the
> > mail.

> I have reverted back to TImur's original patch  so you can just drop
> this patch if that is easier for you.
> You'll just need to coordinate the landing so that things land in the
> right order.

Like I say, since it's a new driver I'm just going to ignore the
ordering since it'll sort itself out in the merge window and we're
rather close to that.  Worst case something that doesn't build isn't
that much different from something that isn't there in terms of
usability.
