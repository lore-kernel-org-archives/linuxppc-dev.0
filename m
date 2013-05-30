Return-Path: <mturquette@linaro.org>
Received: from mail-pb0-x22e.google.com (mail-pb0-x22e.google.com
 [IPv6:2607:f8b0:400e:c01::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 903692C0174
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 May 2013 05:45:07 +1000 (EST)
Received: by mail-pb0-f46.google.com with SMTP id rq2so930536pbb.5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 May 2013 12:45:05 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>, 
From: Mike Turquette <mturquette@linaro.org>
In-Reply-To: <17C23704-7017-427C-A00F-CEFA6247D65D@kernel.crashing.org>
References: <1369210939-25087-1-git-send-email-Yuantian.Tang@freescale.com>
 <20130530185732.4470.91176@quantum> <20130530192143.4470.23214@quantum>
 <17C23704-7017-427C-A00F-CEFA6247D65D@kernel.crashing.org>
Message-ID: <20130530194451.4470.55599@quantum>
Subject: Re: [PATCH] clk/mpc85xx: Update the compatible string
Date: Thu, 30 May 2013 12:44:51 -0700
Cc: Yuantian.Tang@freescale.com, devicetree-discuss@lists.ozlabs.org,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Quoting Kumar Gala (2013-05-30 12:26:38)
> On May 30, 2013, at 2:21 PM, Mike Turquette wrote:
> =

> > Quoting Mike Turquette (2013-05-30 11:57:32)
> >> Quoting Yuantian.Tang@freescale.com (2013-05-22 01:22:19)
> >>> From: Tang Yuantian <yuantian.tang@freescale.com>
> >>> =

> >>> The compatible string of clock is changed from *-2 to *-2.0
> >>> on chassis 2. So updated it accordingly.
> >>> =

> >>> Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
> >> =

> >> Taken into clk-next.
> >> =

> > =

> > One small nitpick.  I updated the $SUBJECT to:
> > =

> > clk: mpc85xx: Update the compatible string
> > =

> > The difference being "clk: mpc85xx:" versus "clk/mpc85xx:".  Please use
> > the former format in the future.
> > =

> > Thanks,
> > Mike
> =

> Mike,
> =

> If clk-ppc-corenet.c went into v3.10, than I think this fix is needed the=
re and shouldn't wait til v3.11
> =


clk-ppc-corenet.c is first introduced in the current clk-next branch.
It is not merged into Linus' tree yet.

Regards,
Mike

> - k
