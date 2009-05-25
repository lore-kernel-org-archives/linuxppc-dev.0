Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 696BADE0E2
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 19:34:48 +1000 (EST)
Date: Mon, 25 May 2009 10:34:41 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH V3 1/4] Main rewite of the mpc5200 audio DMA code
Message-ID: <20090525093439.GA18290@sirena.org.uk>
References: <20090525013606.3073.86753.stgit@terra>
	<20090525013847.3073.55951.stgit@terra>
	<fa686aa40905242326y6a88af84n40f23759661a6cd0@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40905242326y6a88af84n40f23759661a6cd0@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, May 25, 2009 at 12:26:27AM -0600, Grant Likely wrote:
> On Sun, May 24, 2009 at 7:38 PM, Jon Smirl <jonsmirl@gmail.com> wrote:

> > +/* ---------------------------------------------------------------------
> > + * Sysfs attributes for error monitoring
> > + */

> All this sysfs stuff should be dropped from this patch.  It is an
> abuse of sysfs and I never should have written it this way.  Feel free
> to put it in a separate patch so others can use it if they really need
> it, but I'd like it to not be kept in mainline.

If this is going to be kept it should be in debugfs like I said in
response to the v2 posting.
