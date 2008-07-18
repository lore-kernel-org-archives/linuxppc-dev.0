Return-Path: <glikely@secretlab.ca>
Received: from wf-out-1314.google.com (wf-out-1314.google.com [209.85.200.169])
	by ozlabs.org (Postfix) with ESMTP id 4DC33DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 17:17:24 +1000 (EST)
Received: by wf-out-1314.google.com with SMTP id 24so156608wfg.15
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jul 2008 00:17:22 -0700 (PDT)
Date: Fri, 18 Jul 2008 01:17:20 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org,
	liam.girdwood@wolfsonmicro.com, jonsmirl@gmail.com
Subject: Re: [alsa-devel] [PATCH v2 1/3] ALSA SoC: Add OpenFirmware helper
	for matching bus and codec drivers
Message-ID: <20080718071720.GA2174@secretlab.ca>
References: <20080712083929.15025.47682.stgit@trillian.secretlab.ca>
	<20080714134930.GC25448@sirena.org.uk>
	<fa686aa40807141006k402b6a5fq8da1424081a20011@mail.gmail.com>
	<20080714171632.GH25448@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080714171632.GH25448@sirena.org.uk>
Sender: Grant Likely <glikely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 14, 2008 at 06:16:33PM +0100, Mark Brown wrote:
> On Mon, Jul 14, 2008 at 11:06:34AM -0600, Grant Likely wrote:
> 
> > I'm okay with that.  How about fsl/mpc5200-of-machine.c for now?
> > (only the mpc5200 i2s driver uses it at the moment).  It can always be
> > renamed if other folks want to use it for other chips.
> 
> That seems reasonable so long as you're happy with it, though it does
> seem to be going to the other extreme in terms of broadness :) 

Okay, I've changed my mind.  :-)  I'll back off a bit from this extreme and
call it:

sound/soc/fsl/soc-of-simple.c

Does that sound okay?  If non-freescale chips decide to use it then it
can be moved out of the freescale director.

Cheers,
g.
