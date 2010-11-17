Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED3E8B7191
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 18 Nov 2010 03:25:32 +1100 (EST)
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 1/5] scripts: dtc: Merge in changes from the dtc
	repository
In-reply-to: <20101117045935.GA12084@angua.secretlab.ca> 
References: <20101116204917.12146.39851.stgit@riker>
	<20101116204951.12146.21084.stgit@riker>
	<20101117045935.GA12084@angua.secretlab.ca>
Date: Wed, 17 Nov 2010 09:47:55 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1PIkEl-0006Zt-W7@jdl.com>
Cc: glikely@secretlab.ca, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, John Bonesio <bones@secretlab.ca>,
	linuxppc-dev@lists.ozlabs.org, david@gibson.dropbear.id.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Tue, Nov 16, 2010 at 12:49:51PM -0800, John Bonesio wrote:
> > Pull in recent changes from the main dtc repository. These changes primarily
> > allow multiple device trees to be declared which are merged by dtc. This
> > feature allows us to include a basic dts file and then provide more informatio
> n
> > for the specific system through the merging functionality.
> > 
> > Signed-off-by: John Bonesio <bones@secretlab.ca>
> 
> Jon & David, I'll need your input on whether or not this is the best
> way to handle updating the dtc copy in the kernel tree.
> 
> g.

Grant,

Yeah, I wondered too. :-)  David added it and updated
in the kernel last round, so he may have some good notion
of what would be best there.

jdl
