Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 412E1679F3
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Apr 2006 01:57:37 +1000 (EST)
Date: Thu, 13 Apr 2006 10:57:17 -0500
To: Muli Ben-Yehuda <mulix@mulix.org>
Subject: Re: [PATCH] [2/2] POWERPC: Lower threshold for DART enablement to 1GB,
	V2
Message-ID: <20060413155717.GF24769@pb15.lixom.net>
References: <20060413020559.GC24769@pb15.lixom.net>
	<20060413022809.GD24769@pb15.lixom.net>
	<20060413025233.GE24769@pb15.lixom.net>
	<20060413064027.GH10412@granada.merseine.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060413064027.GH10412@granada.merseine.nu>
From: Olof Johansson <olof@lixom.net>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Apr 13, 2006 at 09:40:27AM +0300, Muli Ben-Yehuda wrote:
> On Wed, Apr 12, 2006 at 09:52:33PM -0500, Olof Johansson wrote:
> 
> > iommu=off can still be used for those who don't want to deal with the
> > overhead (and don't need it for any devices).
> 
> I've been pondering walking the PCI bus before deciding to enable an
> IOMMU and checking each device's DMA mask. Is this something that you
> considered and rejected, or just something no one got around to doing?

It's something I thought about, but right now we enable the IOMMU quite
early during boot. It'd take a bit of surgery to shuffle things, and I
decided that it's not worth the work (and risk of regressions) for 2.6.17.



-Olof
