Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 9D2B3DE044
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Jan 2009 15:37:59 +1100 (EST)
Date: Sun, 4 Jan 2009 20:36:46 -0800
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the driver-core tree
Message-ID: <20090105043646.GB16341@kroah.com>
References: <20081204104418.97f848b4.sfr@canb.auug.org.au>
	<20081204042154.GA18027@kroah.com>
	<20090105102800.c73bed11.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090105102800.c73bed11.sfr@canb.auug.org.au>
Cc: Kay Sievers <kay.sievers@vrfy.org>, linuxppc-dev@ozlabs.org,
	linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 05, 2009 at 10:28:00AM +1100, Stephen Rothwell wrote:
> Hi Greg,
> 
> On Wed, 3 Dec 2008 20:21:54 -0800 Greg KH <greg@kroah.com> wrote:
> >
> > On Thu, Dec 04, 2008 at 10:44:18AM +1100, Stephen Rothwell wrote:
> > > 
> > > Today's linux-next merge of the driver-core tree got a conflict in
> > > arch/powerpc/platforms/85xx/mpc85xx_mds.c between commit
> > > 24a99596f7465274a8e65ddd29a7d9028969b9f9 ("powerpc/85xx: Fix compile
> > > warnings in mpc85xx_mds.c") from the galak tree and commit
> > > f58f23751464d095f9942304bc5f6072b79a2cc3 ("powerpc: struct device -
> > > replace bus_id with dev_name(), dev_set_name()") from the driver-core
> > > tree.
> > > 
> > > I fixed it up (see below) and can carry the fix as necessary.
> > > 
> > > Paul, maybe you should apply the patch from the driver-core tree as it
> > > was cc'd to you and all its prerequisites are upstream.
> > 
> > Yes, Paul, please apply the patch, and let me know.  It will make things
> > much easier in the end for everyone involved.
> 
> It looks like this has been applied to the powerpc tree and is now in
> Linus' tree.

Thanks for letting me know, I'll drop it from my tree when I sync up
with Linus's tree tomorrow.

greg k-h
