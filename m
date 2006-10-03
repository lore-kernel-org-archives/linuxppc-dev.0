Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp-msa-out06.orange.fr (smtp6.orange.fr [193.252.22.25])
	by ozlabs.org (Postfix) with ESMTP id EF0C367C1B
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 02:31:46 +1000 (EST)
Date: Tue, 3 Oct 2006 18:29:05 +0200
To: Olaf Hering <olaf@aepfle.de>
Subject: Re: [PATCH] mv643xx_eth_pcidev : implement hotplug by matching the
	Discovery II/III northbridge pci id (Was: +
	mv643xx_eth_pcidev-implements-hotplug-for-the-marvell-gige-functionality-by-probing-the-northbridge-pci-id.patch
	added to -mm tree)
Message-ID: <20061003162905.GA1006@powerlinux.fr>
References: <200510250811.j9P8B7db002405@shell0.pdx.osdl.net>
	<20060919151611.GA15580@powerlinux.fr>
	<20060919093410.e454e465.akpm@osdl.org>
	<20061003123303.GB23670@powerlinux.fr>
	<20061003142355.GA26207@aepfle.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20061003142355.GA26207@aepfle.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Sven Luther <sl@bplan-gmbh.de>, Jeff Garzik <jeff@garzik.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 03, 2006 at 04:23:55PM +0200, Olaf Hering wrote:
> On Tue, Oct 03, Sven Luther wrote:
> 
> > Match the Marvell Discovery II/III northbridge pci id to add hotplug
> > support for the builtin gigabit ethernet driver (mv643xx_eth).
> 
> there is no need for this patch. a0245f7ad5214cb00131d7cd176446e067c913dc fixed it.

I think that is a limited description, not sure.

> Put this in your early boot scripts:
> 
> for i in `find /sys -name modalias`;do /sbin/modprobe -v "`cat $i`"&done

Does this also account for all those distributions out there who have pure
udev based installers ? 

Friendly,

Sven Luther
