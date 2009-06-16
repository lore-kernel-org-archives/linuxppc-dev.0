Return-Path: <greg@kroah.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D6561B70C6
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 16:24:20 +1000 (EST)
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 7D14CDDDA1
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 16:24:20 +1000 (EST)
Date: Mon, 15 Jun 2009 23:18:49 -0700
From: Greg KH <greg@kroah.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: linux-next: manual merge of the driver-core tree with the
	powerpc tree
Message-ID: <20090616061849.GA32109@kroah.com>
References: <20090616155317.d1f1217e.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090616155317.d1f1217e.sfr@canb.auug.org.au>
Cc: Roel Kluin <roel.kluin@gmail.com>, linux-kernel@vger.kernel.org,
	ppc-dev <linuxppc-dev@ozlabs.org>, linux-next@vger.kernel.org,
	Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 16, 2009 at 03:53:17PM +1000, Stephen Rothwell wrote:
> Hi Greg,
> 
> Today's linux-next merge of the driver-core tree got a conflict in
> drivers/block/ps3disk.c between commits
> 6dee2c87ebbe5d7ce8c4c163966a0bd9c02c75ef ("block/ps3: remove driver_data
> direct access of struct device") and
> 03fa68c245cccbcb99035cbabaa13b408ba91ab5 ("ps3: shorten ps3_system_bus_
> [gs]et_driver_data to ps3_system_bus_[gs]et_drvdata") from the powerpc
> tree and commit db7afa200c4ef6823a2a40e4ea1dd747775be01a ("block/ps3:
> remove driver_data direct access of struct device") from the driver-core
> tree.
> 
> I fixed it up (I used the version from the powerpc tree).  Greg, I think
> the driver-core patch is no longer relevant.

I pushed out an update a number of hours ago (like 6+), so you should
have gotten it with this update.

When did you pull from my tree?  I also just sent a merge request to
Linus, so everything should be fixed up now.

thanks,

greg k-h
