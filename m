Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.238])
	by ozlabs.org (Postfix) with ESMTP id AECC4DDF44
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Mar 2008 08:43:45 +1100 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so5004310wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Mar 2008 14:43:43 -0700 (PDT)
Message-ID: <fa686aa40803171443q7a53f0balbb49740116c6552@mail.gmail.com>
Date: Mon, 17 Mar 2008 15:43:43 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Wolfgang Denk" <wd@denx.de>
Subject: Re: Please pull linux-2.6-mpc52xx.git
In-Reply-To: <20080317205956.BAC85241A2@gemini.denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <fa686aa40803171219s7135a0f8n91bcd20329a94637@mail.gmail.com>
	<20080317205956.BAC85241A2@gemini.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Mar 17, 2008 at 2:59 PM, Wolfgang Denk <wd@denx.de> wrote:
> In message <fa686aa40803171219s7135a0f8n91bcd20329a94637@mail.gmail.com> you wrote:
>  >
>  > >  What is the status of the various MPC5200-related patches (support for
>  > >  TQM5200, CM5200 and Motion-PRO boards, few drivers, etc) posted some
>  > >  time ago by Marian Balakowicz? There's been some comments to the patches
>  > >  on the list, which were addressed and no further discussion occurred, so
>  > >  we were hoping that the changes would go upstream (in 2.6.25). I can see
>  > >  that the .dts files for those boards are in the mainline already, but I
>  > >  see no trace of for example _defconfig files -- could you shed some
>  > >  light on this?
>  >
>  > Yes, the separate dts files have been dropped in preference for a
>  > single mpc5200_defconfig for all 5200 boards.
>
>  I know that my opinion doesn't matter but that's a  stupid  thing  to
              ^^^^^^^^^^^^^^^^^^^^^^^^^
Bull.  You know better than that.

>  do. Do you think that this single mpc5200_defconfig will (a) work and
>  (b)  be  useful  on all 5200 boards? Who hast tested it, and on which
>  platforms?

a) the same way we know that 5200 ethernet driver (for example) works
on all 5200 boards.  If it breaks for one board then we fix it.
b) defconfigs is more about testing and a known working configuration
than it is about a distribution configuration.  It's not intended to
be the deployed config.  For a distribution/deployable image it is
expected that the engineer responsible will tailor the config.

>  And what about the other patches? I see no code for these boards in
>  arch/powerpc/platforms/52xx/ ?

All these boards are supported with
arch/powerpc/platforms/mpc5200_simple.c.  A kernel built for that
platform will boot on any of those boards as long as it is passed the
correct device tree.

Cheers,
g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
