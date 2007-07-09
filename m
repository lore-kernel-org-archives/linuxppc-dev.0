Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C8AE4DDDFE
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jul 2007 03:08:04 +1000 (EST)
Date: Mon, 9 Jul 2007 12:19:26 -0500
From: Olof Johansson <olof@lixom.net>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [patch 01/35] pasemi: rename platform
Message-ID: <20070709171925.GA7083@lixom.net>
References: <20070705170233.258351000@lixom.net>
	<20070705170233.671358000@lixom.net>
	<20070709095259.0720669b.sfr@canb.auug.org.au>
	<20070709001835.GA30821@lixom.net>
	<20070709172302.149e3fe0.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070709172302.149e3fe0.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jul 09, 2007 at 05:23:02PM +1000, Stephen Rothwell wrote:
> On Sun, 8 Jul 2007 19:18:35 -0500 Olof Johansson <olof@lixom.net> wrote:
> >
> > On Mon, Jul 09, 2007 at 09:52:59AM +1000, Stephen Rothwell wrote:
> > > 
> > > This should also fix a problem further up in that file (in
> > > pasemi_publish_devices) where we check for "machine_is(pasemi)".
> > 
> > Yup, that's how I discovered the machine name being less than intuitive.
> 
> So it is worth noting in the chnge log.

Yeah sure, but not enough to repost the patch. The only problem it causes
is that a driver introduced a little earlier (but in the same release)
won't probe until this is applied.


-Olof
