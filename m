Return-Path: <sam@ravnborg.org>
Received: from pfepb.post.tele.dk (pfepb.post.tele.dk [195.41.46.236])
	by ozlabs.org (Postfix) with ESMTP id 56E79B6F06
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Aug 2010 16:48:50 +1000 (EST)
Date: Tue, 3 Aug 2010 08:48:48 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Thomas Backlund <tmb@mandriva.org>
Subject: Re: make 3.82 fails on powerpc defconfig update [was: Linux 2.6.35]
Message-ID: <20100803064848.GB19193@merkur.ravnborg.org>
References: <AANLkTim8FALeVG+NPLNLEQChu=dPD=GHSpnxmZHYgsNx@mail.gmail.com>
	<4C5686FF.9010803@mandriva.org>
	<20100802182848.GA16394@merkur.ravnborg.org>
	<4C572EB0.7060706@mandriva.org>
	<20100802205121.GA16520@merkur.ravnborg.org>
	<4C5732A7.2050003@mandriva.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4C5732A7.2050003@mandriva.org>
Cc: Michal Marek <mmarek@suse.cz>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
	"bug-make@gnu.org" <bug-make@gnu.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Aug 03, 2010 at 12:03:35AM +0300, Thomas Backlund wrote:
> 02.08.2010 23:51, Sam Ravnborg skrev:
> >>
> >> Thanks, this seems to fix the first issue, but then I get the same erro on the following line 190:
> >>
> >> 190: bootwrapper_install %.dtb:
> >> 191:        $(Q)$(MAKE) ARCH=ppc64 $(build)=$(boot) $(patsubst %,$(boot)/%,$@)
> >>
> > 
> > Obviously - dunno how I missed that.
> > Updated patch below.
> > 
> > I will do a proper submission after you
> > confirm that powerpc build is working with make 3.82.
> > 
> 
> Yeah, that was an obvious fix, thanks!
> 
> One small typo fix below...
> (a missing ':')
> 
> Otherwise it works here, so:
> 
> Tested-by: Thomas Backlund <tmb@mandriva.org>

Thanks.
I have sent a proper patch to Ben/Paul (powerpc maintainers).

	Sam
