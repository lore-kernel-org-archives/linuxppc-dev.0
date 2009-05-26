Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6A78DE00B
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 19:21:47 +1000 (EST)
Date: Tue, 26 May 2009 10:21:38 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [alsa-devel] [PATCH V4 0/5] AC97 driver for mpc5200
Message-ID: <20090526092137.GA2645@sirena.org.uk>
References: <20090525221406.21370.30326.stgit@terra>
	<ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <ed82fe3e0905252044w1d0e1f5cqbaf4256b9f749d42@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 10:44:12PM -0500, Timur Tabi wrote:
> On Mon, May 25, 2009 at 5:15 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> > ? ? ?The macro spin_event_timeout() takes a condition and timeout value

> My patch is already set to go through the powerpc tree, so there's no
> need to repost it here.  Please, you changed the title of the patch.

Indeed.  Since this is a new driver I'm happy to let the code go in
without the new function and then sort itself out in the merge window.
