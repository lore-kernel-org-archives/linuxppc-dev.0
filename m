Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	by ozlabs.org (Postfix) with ESMTP id C603BDDEE8
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jul 2008 01:37:00 +1000 (EST)
Date: Wed, 23 Jul 2008 16:36:55 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: [alsa-devel] [PATCH 2/2] Allow a custom ASOC machine driver with
	soc-of-simple
Message-ID: <20080723153642.GB22926@sirena.org.uk>
References: <20080722235349.11648.90112.stgit@terra>
	<20080722235351.11648.56387.stgit@terra>
	<20080723105334.GC8377@sirena.org.uk>
	<9e4733910807230709l4249eaf6m750bad811342ba13@mail.gmail.com>
	<20080723151431.GA22926@sirena.org.uk>
	<9e4733910807230816m474af04ch9b6650cdbb96ffec@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910807230816m474af04ch9b6650cdbb96ffec@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jul 23, 2008 at 11:16:17AM -0400, Jon Smirl wrote:
> On 7/23/08, Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> >  I'd also expect something to handle the existing user.

> This is a modification to Grant's new driver. Grant is the only other user.

Right, hence my use of the singular : ) .  Since you are adding this new
of_snd_soc_register_machine() Grant's existing platform won't be calling
it yet and will therefore stop instantiating the ASoC subsystem until it
is changed to do so.
