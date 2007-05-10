Return-Path: <kou.ishizaki@toshiba.co.jp>
Received: from imx12.toshiba.co.jp (imx12.toshiba.co.jp [61.202.160.132])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 01518DDE09
	for <linuxppc-dev@ozlabs.org>; Thu, 10 May 2007 17:14:27 +1000 (EST)
Date: Thu, 10 May 2007 16:14:18 +0900 (JST)
Message-Id: <20070510.161418.-1300530995.kouish@swc.toshiba.co.jp>
To: benh@kernel.crashing.org
Subject: Re: [PATCH 1/4] celleb: fix supporting for multiple pci domains
In-Reply-To: <1178697002.14928.157.camel@localhost.localdomain>
From: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Ben-san,

> > Celleb has multiple PCI host bridges (phbs). Previous boot logic
gives
> > non-overlapped bus IDs between PCI host bridges so you can identify
> > PHB by bus ID. But newer boot logic gives same bus ID between PHBs
(it
> > gives bus ID 0 as root bus.) So we have to set 'phb->buid' as
> > non-zero.
> 
> Shouldn't you obtain it from the device-tree ?

With 'Celleb', we don't have 'buid' in the device-tree, because neither
hypervisor calls nor RTAS subsystem uses 'buid.' So we didn't choose
to obtain 'buid' from the device-tree.

Best regards,
Kou Ishizaki
