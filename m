Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5B480DE0B0
	for <linuxppc-dev@ozlabs.org>; Tue, 26 May 2009 23:03:10 +1000 (EST)
Date: Tue, 26 May 2009 14:03:01 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [PATCH V5 1/5] powerpc: introduce macro spin_event_timeout()
Message-ID: <20090526130301.GE8969@sirena.org.uk>
References: <20090526123235.17472.73912.stgit@terra>
	<20090526123406.17472.79948.stgit@terra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090526123406.17472.79948.stgit@terra>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, May 26, 2009 at 08:34:06AM -0400, Jon Smirl wrote:
> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters.  It spins until either the condition is true
> or the timeout expires.  It returns the result of the condition when the loop
> was terminated.

As previously mentioned you need to submit any changes you want to make
here as incremental patches against the PowerPC tree rather than as an
entire new patch.  If you are forwarding on copies of the patch you
really ought to preserve Timur's authorship too with a From line in the
mail.
