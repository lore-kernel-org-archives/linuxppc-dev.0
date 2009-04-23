Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [213.79.90.228])
	by ozlabs.org (Postfix) with ESMTP id 4856EDE5B8
	for <linuxppc-dev@ozlabs.org>; Fri, 24 Apr 2009 00:03:29 +1000 (EST)
Date: Thu, 23 Apr 2009 18:03:23 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: removing get_immrbase()??
Message-ID: <20090423140323.GA24671@oksana.dev.rtsoft.ru>
References: <A6732FD8-FBC6-420F-9318-CC111D266993@kernel.crashing.org>
	<ed82fe3e0904221235i51fb75dap44b1fad09a10ea91@mail.gmail.com>
	<49EF7B11.2000006@freescale.com> <49EF7B1C.2080105@freescale.com>
	<282847E1-AE1A-44EF-9D18-AF2884105FA5@kernel.crashing.org>
	<fa686aa40904230653j6855f8bai5248b250eb3ef515@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <fa686aa40904230653j6855f8bai5248b250eb3ef515@mail.gmail.com>
Cc: Scott Wood <scottwood@freescale.com>,
	Linuxppc-dev Development <linuxppc-dev@ozlabs.org>,
	Timur Tabi <timur@freescale.com>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 23, 2009 at 07:53:11AM -0600, Grant Likely wrote:
> On Wed, Apr 22, 2009 at 3:31 PM, Kumar Gala <galak@kernel.crashing.org> wrote:
> >
> > On Apr 22, 2009, at 3:16 PM, Timur Tabi wrote:
> >
> >> Scott Wood wrote:
> >>>
> >>> Timur Tabi wrote:
> >>>>>
> >>>>>      these two are related and seem like we could look for "fsl,cpm2"
> >>>>
> >>>> That's okay, as long as you don't break compatibility with older
> >>>> device trees that don't have that property, unless you can demonstrate
> >>>> that these trees would never work with the current kernel anyway.
> >>>
> >>> All CPM2 device trees should have fsl,cpm2 listed in the compatible of
> >>> the CPM node.
> >>
> >> Yes, but did they always have that compatible field?  I'm concerned
> >> about situations where someone updates his kernel but not his device
> >> tree.  This is a scenerio that we always need to try to support.
> >
> > I disagree.  If you update your kernel you should update your device tree
> > (thus we have .dts in the kernel tree and not somewhere else).
> 
> Not always possible.  The device tree may be 'softer' than firmware,
> and easier to update, but it is still firmer than the kernel.  That is
> why so much effort has been spent to not break compatibility with
> older device trees.

I'd suggest to deal with this on case-by-case basis. In every MPC8xx
and MPC8xxx boards I've seen from Freescale there is absolutely no
difference in upgrading kernel or device-tree blob.

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
