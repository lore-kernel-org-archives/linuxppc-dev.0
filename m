Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2B7CFDDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  9 May 2007 17:50:08 +1000 (EST)
Subject: Re: [PATCH 1/4] celleb: fix supporting for multiple pci domains
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Ishizaki Kou <kou.ishizaki@toshiba.co.jp>
In-Reply-To: <200705090734.l497YJqU004144@toshiba.co.jp>
References: <200705090734.l497YJqU004144@toshiba.co.jp>
Content-Type: text/plain
Date: Wed, 09 May 2007 17:50:02 +1000
Message-Id: <1178697002.14928.157.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-05-09 at 16:34 +0900, Ishizaki Kou wrote:
> Celleb has multiple PCI host bridges (phbs). Previous boot logic gives
> non-overlapped bus IDs between PCI host bridges so you can identify
> PHB by bus ID. But newer boot logic gives same bus ID between PHBs (it
> gives bus ID 0 as root bus.) So we have to set 'phb->buid' as
> non-zero.

Shouldn't you obtain it from the device-tree ?

Ben.
