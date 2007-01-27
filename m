Return-Path: <flar@cynthia.pants.nu>
Received: from cynthia.pants.nu (adsl-216-102-214-42.dsl.snfc21.pacbell.net
	[216.102.214.42]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1C537DDFC4
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Jan 2007 06:03:33 +1100 (EST)
Date: Sat, 27 Jan 2007 14:24:03 -0800
From: Brad Boyer <flar@allandria.com>
To: debian-kernel@lists.debian.org, linuxppc-dev@ozlabs.org
Subject: Re: Mac devices on PREP
Message-ID: <20070127222403.GA24831@cynthia.pants.nu>
References: <20070128120126.GA21984@wavehammer.waldi.eu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070128120126.GA21984@wavehammer.waldi.eu.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Jan 28, 2007 at 01:01:26PM +0100, Bastian Blank wrote:
> Currently, the whole bunch of macintosh devices (drivers/macintosh) are
> listed to be available on all ppc variants. Some of them does not build
> for prep.
> 
> The attached patch restricts the whole bunch to PPC_PMAC. I'm not sure
> if this is the correct fix.

I don't know if it still works, but there used to be support for
ADB on CHRP hardware. I don't have any such hardware to check, so
someone else will have to comment on that. This is one reason I
suggested moving ADB out of drivers/macintosh, but at the time
there was disagreement on that and I never finished the patch I
was work on anyway.

Perhaps it should be (PPC_PMAC || PPC_CHRP || MAC) instead as a
simple fix to prevent it from building on prep.

	Brad Boyer
	flar@allandria.com
