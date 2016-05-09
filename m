Return-Path: <mikey@neuling.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3Kp65r0JzDq5m
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  9 May 2016 21:26:22 +1000 (AEST)
Message-ID: <1462793182.21401.7.camel@neuling.org>
Subject: Re: [PATCH v2 1/2] powerpc/timer - large decrementer support
From: Michael Neuling <mikey@neuling.org>
To: oliver <oohall@gmail.com>, Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Jack Miller <jack@codezen.org>
Date: Mon, 09 May 2016 21:26:22 +1000
In-Reply-To: <CAOSf1CEAuXV8p5nDm1Pqsx90Jek-SE7ev_37bjjh+7gsc=fY_g@mail.gmail.com>
References: <1462347433-26150-1-git-send-email-oohall@gmail.com>
 <ccffddae-6e91-d8ad-5d33-f926b021b76b@gmail.com>
 <CAOSf1CEAuXV8p5nDm1Pqsx90Jek-SE7ev_37bjjh+7gsc=fY_g@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


> > > +static inline bool large_dec_supp(void)
> > > +{
> > > +=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0return cpu_has_feature(CPU_FTR_ARCH_30=
0);
> > > +}
> > > +
> > Can we rename this to is_large_dec()?
> Honestly, I don't like either. How about have_large_dec() ?

How about cpu_has_large_dec() like the underlying call?

Mikey
