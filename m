Return-Path: <bcook@bpointsys.com>
Received: from bpointsys.com (70-253-197-251.ded.swbell.net [70.253.197.251])
	by ozlabs.org (Postfix) with ESMTP id 32D3067C44
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 03:49:24 +1000 (EST)
From: Brent Cook <bcook@bpointsys.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] mv643xx_eth_pcidev : implement hotplug by matching the
	Discovery II/III northbridge pci id (Was: +
	mv643xx_eth_pcidev-implements-hotplug-for-the-marvell-gige-functionality-by-probing-the-northbridge-pci-id.patch
	added to -mm tree)
Date: Tue, 3 Oct 2006 12:37:10 -0500
References: <200510250811.j9P8B7db002405@shell0.pdx.osdl.net>
	<20061003164605.GA27962@aepfle.de>
	<20061003170933.GA2386@powerlinux.fr>
In-Reply-To: <20061003170933.GA2386@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200610031237.11133.bcook@bpointsys.com>
Cc: Andrew Morton <akpm@osdl.org>, Olaf Hering <olaf@aepfle.de>,
	Sven Luther <sl@bplan-gmbh.de>, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tuesday 03 October 2006 12:09, Sven Luther wrote:
> On Tue, Oct 03, 2006 at 06:46:05PM +0200, Olaf Hering wrote:
> > On Tue, Oct 03, Sven Luther wrote:
> > > Does this also account for all those distributions out there who have
> > > pure udev based installers ?
> >
> > Maybe udev does just a 'modprobe $MODALIAS', I dont know.
>
> Do you have a more complete url to the patch ? Just googling for the
> checksum didn't bring anything.

Is this it? I just pasted the md5 sum into the search box:

http://kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=a0245f7ad5214cb00131d7cd176446e067c913dc

> I will investigate the udev side of this.
>
> Friendly,
>
> Sven Luther
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
