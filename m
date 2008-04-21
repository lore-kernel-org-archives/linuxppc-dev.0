Return-Path: <glikely@secretlab.ca>
Received: from wx-out-0506.google.com (wx-out-0506.google.com [66.249.82.228])
	by ozlabs.org (Postfix) with ESMTP id ABE58DE6AF
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Apr 2008 02:58:02 +1000 (EST)
Received: by wx-out-0506.google.com with SMTP id h27so1381363wxd.15
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Apr 2008 09:58:00 -0700 (PDT)
Message-ID: <fa686aa40804210958x59b5a1e2r1085f57e0ead235c@mail.gmail.com>
Date: Mon, 21 Apr 2008 10:58:00 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Bartlomiej Sieka" <tur@semihalf.com>
Subject: Re: [PATCH] [POWERPC] 52xx: defconfigs for CM5200, Lite5200B,
	Motion-PRO and TQM5200
In-Reply-To: <480CC6F9.3050700@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20080415103635.9629.55344.stgit@pollux.denx.de>
	<480C9D38.3020902@semihalf.com>
	<fa686aa40804210726w3e8f4647mbc3dad8e48a124c0@mail.gmail.com>
	<480CC6F9.3050700@semihalf.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 21, 2008 at 10:55 AM, Bartlomiej Sieka <tur@semihalf.com> wrote:
> Grant Likely wrote:
>
> > On Mon, Apr 21, 2008 at 7:57 AM, Bartlomiej Sieka <tur@semihalf.com>
> wrote:
> >
> > > Bartlomiej Sieka wrote:
> > >
> > >
> > > > Board-specific defconfigs based on current mpc5200_defconfig, archival
> > > > lite5200_defconfig, and [cm5200|motionpro|tqm5200]_defconfig from the
> > > > linux-2.6-denx tree. Kernels build using these defconfigs were
> verified
> > > > to boot with root filesystem mounted over NFS on Motion-PRO, TQM5200
> > > > and Lite5200B boards. CM5200 target was not tested due to hardware
> > > > unavailability.
> > > >
> > > >
> > >  Hello Grant,
> > >
> > >  There hasn't been any negitve comments on the above patch -- will you
> > >  push it upstream via your tree?
> > >
> >
> > Yes, of course.
> >
>
>  Thanks -- is it safe to assume that the patch will make it into 2.6.26
> then?

Yes; defconfigs are easy to get merged.

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
