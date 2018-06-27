Return-Path: <paubert@iram.es>
Received: from telmad-lavadora-l1mail2.puc.rediris.es
 (te-l1mail2-out06a.puc.rediris.es [IPv6:2001:720:418:ca03::88])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Fxr16zcszF153
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Jun 2018 19:07:13 +1000 (AEST)
Date: Wed, 27 Jun 2018 11:00:22 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Michael Schmitz <schmitzmic@gmail.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Finn Thain <fthain@telegraphics.com.au>, geert@linux-m68k.org,
 linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 00/12] macintosh: Resolve various PMU driver problems
Message-ID: <20180627090022.rij2owx5durbc4e6@lt-gp.iram.es>
References: <cover.1528885172.git.fthain@telegraphics.com.au>
 <alpine.LNX.2.21.1806242119180.34@nippy.intranet>
 <874lhp6i4d.fsf@concordia.ellerman.id.au>
 <cacaecac00c1ac941a78da772bbcfb05142df87d.camel@kernel.crashing.org>
 <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5d4d7ca4-1d2f-268f-e5d2-eddb213e894d@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 27, 2018 at 05:39:15PM +1200, Michael Schmitz wrote:
> Ben,
> 
> Am 27.06.2018 um 15:27 schrieb Benjamin Herrenschmidt:
> > On Wed, 2018-06-27 at 13:08 +1000, Michael Ellerman wrote:
> > > > I will rewrite patch 10/12 after Arnd's fixes and this series have all
> > > > made their way through both powerpc and m68k trees, and submit it
> > > > separately.
> > > 
> > > drivers/macintosh is supposedly maintained by Ben, but I'm not sure this
> > > series is high on his todo list.
> > 
> > We need at least to pull out a couple of powerbooks we have sitting in
> > drawers and try it out.
> 
> No need to root around in drawers - I'm sitting in front of one (G3
> Titanium) writing this. Let me know if that would help (I've forgotten most
> of what I knew about powerpc kernels).

A very rare model, all G3 I've seen were plastic, all Titanium were G4 :-)

	Cheers,
	Gabriel
	(still using my Pismo from time to time, but much less since
	sleep was broken)
