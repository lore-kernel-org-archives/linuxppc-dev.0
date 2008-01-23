Return-Path: <jonsmirl@gmail.com>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.182])
	by ozlabs.org (Postfix) with ESMTP id C25FEDDEFF
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Jan 2008 01:40:39 +1100 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so5204525wag.13
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Jan 2008 06:40:38 -0800 (PST)
Message-ID: <9e4733910801230640u6e02ed07r476c201895d46d9f@mail.gmail.com>
Date: Wed, 23 Jan 2008 09:40:38 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Jon Loeliger" <jdl@jdl.com>
Subject: Re: [PATCH 2/3] Convert PowerPC MPC i2c to of_platform_driver from
	platform_driver
In-Reply-To: <E1JHgdB-0002zV-F4@jdl.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080123020912.31675.48787.stgit@terra.home>
	<20080123020914.31675.35659.stgit@terra.home>
	<E1JHgdB-0002zV-F4@jdl.com>
Cc: linuxppc-dev@ozlabs.org, i2c@lm-sensors.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/23/08, Jon Loeliger <jdl@jdl.com> wrote:
> So, like, the other day Jon Smirl mumbled:
> > Convert MPC i2c driver from a platform_driver to a
> > of_platform_driver. Add the ability to dynamically load i2c drivers
> > based on device tree names. Routine names were changed from fsl_ to
> > mpc_ to make them match the file name. Common code moved to
> > powerpc-common.* Orginal ppc driver left intact for deletion when ppc
> > arch is removed.
>
> This seems backwards to me.  I was under the impression
> that our trend was _toward_ "Freescale" and "fsl" names...?
> And aren't the drivers also already using "fsl-i2c" in the
> DTS files as called out in the b-w-o.txt too?

The routine names should match the file name which then determines the
module name. I didn't want to change the module name so I made the
routines names match the module name.

>
> Grumble long lines not hard-limited to 70-ish columns,
> yes, even in log messages... :-)
>
> jdl
>


-- 
Jon Smirl
jonsmirl@gmail.com
