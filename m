Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.176])
	by ozlabs.org (Postfix) with ESMTP id A6FAEDDDEC
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 13:50:15 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so4868239wag.13
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Jan 2008 18:50:13 -0800 (PST)
Message-ID: <9e4733910801221850k406f0985jd072876b681299da@mail.gmail.com>
Date: Tue, 22 Jan 2008 21:50:13 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/3] Rename i2c-mpc to i2c-mpc-drv in preparation for
	breaking out common code.
In-Reply-To: <20080123134654.cb5e249d.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123134654.cb5e249d.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/22/08, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> Hi Jon,
>
> On Tue, 22 Jan 2008 21:09:12 -0500 Jon Smirl <jonsmirl@gmail.com> wrote:
> >
> > Rename i2c-mpc to i2c-mpc-drv in preparation for breaking out common code.
> >
> > Signed-off-by: Jon Smirl <jonsmirl@gmail.com>
> > ---
> >
> >  drivers/i2c/busses/Makefile      |    2
> >  drivers/i2c/busses/i2c-mpc-drv.c |  421 ++++++++++++++++++++++++++++++++++++++
> >  drivers/i2c/busses/i2c-mpc.c     |  421 --------------------------------------
> >  3 files changed, 423 insertions(+), 421 deletions(-)
> >  create mode 100644 drivers/i2c/busses/i2c-mpc-drv.c
> >  delete mode 100644 drivers/i2c/busses/i2c-mpc.c
>
> Adding -M or -C to the "git diff" should identify renames and
> makes this sort of patch much easier to review.

I use stgit, I'll ask them how to generate rename patches. The actual
git diff is buried inside stgit somewhere.

>
> --
> Cheers,
> Stephen Rothwell                    sfr@canb.auug.org.au
> http://www.canb.auug.org.au/~sfr/
>
>


-- 
Jon Smirl
jonsmirl@gmail.com
