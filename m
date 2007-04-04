Return-Path: <galibert@dspnet.fr.eu.org>
Received: from dspnet.fr.eu.org (dspnet.fr.eu.org [213.186.44.138])
	by ozlabs.org (Postfix) with ESMTP id 6B596DDE24
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Apr 2007 22:45:41 +1000 (EST)
Date: Wed, 4 Apr 2007 14:20:53 +0200
From: Olivier Galibert <galibert@pobox.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Message-ID: <20070404122053.GA10599@dspnet.fr.eu.org>
References: <20070404022828.5c9b97f3@the-village.bc.nu>
	<Pine.LNX.4.63.0704031804350.21680@qynat.qvtvafvgr.pbz>
	<20070404024400.56d016e1@the-village.bc.nu>
	<20070403.185026.26966290.davem@davemloft.net>
	<20070404121434.73d01e7e@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070404121434.73d01e7e@the-village.bc.nu>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	dwmw2@infradead.org, David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 04, 2007 at 12:14:34PM +0100, Alan Cox wrote:
> > If you want hierarchy, create it:
> > 
> > /sys/blah/serial/controllerX/portY
> > 
> > and keeping them all under the ttyS? major keeps the simple
> > cases working sanely too.
> 
> Currently yes you could do that, but that would break all the back
> compatibility.

libata's hd->s* does that too, with probably a much larger impact.
Could udev be useful for once and make back compatibility symlinks?
Unifying serial the same way disks, cdroms, network, etc got unified
has some charm.

  OG.
