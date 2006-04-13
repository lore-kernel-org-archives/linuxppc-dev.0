Return-Path: <muli@granada.merseine.nu>
Received: from mtaout4.012.net.il (mtaout4.012.net.il [84.95.2.10])
	by ozlabs.org (Postfix) with ESMTP id 5824A67BF5
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Apr 2006 16:42:13 +1000 (EST)
Received: from granada.merseine.nu ([87.69.40.180])
	by i_mtaout4.012.net.il (HyperSendmail v2004.12)
	with ESMTP id <0IXN00DBZEPUVN30@i_mtaout4.012.net.il> for
	linuxppc-dev@ozlabs.org; Thu, 13 Apr 2006 09:44:19 +0300 (IDT)
Date: Thu, 13 Apr 2006 09:40:27 +0300
From: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
In-reply-to: <20060413025233.GE24769@pb15.lixom.net>
To: Olof Johansson <olof@lixom.net>
Message-id: <20060413064027.GH10412@granada.merseine.nu>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:

> iommu=off can still be used for those who don't want to deal with the
> overhead (and don't need it for any devices).

I've been pondering walking the PCI bus before deciding to enable an
IOMMU and checking each device's DMA mask. Is this something that you
considered and rejected, or just something no one got around to doing?

Cheers,
Muli
-- 
Muli Ben-Yehuda
http://www.mulix.org | http://mulix.livejournal.com/
