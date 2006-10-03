Return-Path: <olaf@ibook.aepfle.de>
Received: from natlemon.rzone.de (natlemon.rzone.de [81.169.145.170])
	by ozlabs.org (Postfix) with ESMTP id 6F98567C03
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 02:47:49 +1000 (EST)
Date: Tue, 3 Oct 2006 18:46:05 +0200
From: Olaf Hering <olaf@aepfle.de>
To: Sven Luther <sven.luther@wanadoo.fr>
Subject: Re: [PATCH] mv643xx_eth_pcidev : implement hotplug by matching the
	Discovery II/III northbridge pci id (Was: +
	mv643xx_eth_pcidev-implements-hotplug-for-the-marvell-gige-functionality-by-probing-the-northbridge-pci-id.patch
	added to -mm tree)
Message-ID: <20061003164605.GA27962@aepfle.de>
References: <200510250811.j9P8B7db002405@shell0.pdx.osdl.net>
	<20060919151611.GA15580@powerlinux.fr>
	<20060919093410.e454e465.akpm@osdl.org>
	<20061003123303.GB23670@powerlinux.fr>
	<20061003142355.GA26207@aepfle.de>
	<20061003162905.GA1006@powerlinux.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20061003162905.GA1006@powerlinux.fr>
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

On Tue, Oct 03, Sven Luther wrote:

> Does this also account for all those distributions out there who have pure
> udev based installers ? 

Maybe udev does just a 'modprobe $MODALIAS', I dont know.
