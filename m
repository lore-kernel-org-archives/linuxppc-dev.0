Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3035DDDDE7
	for <linuxppc-dev@ozlabs.org>; Tue, 21 Oct 2008 17:11:55 +1100 (EST)
Message-ID: <48FD7292.5020401@garzik.org>
Date: Tue, 21 Oct 2008 02:11:30 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jeff Kirsher <jeffrey.t.kirsher@intel.com>
Subject: Re: [PATCH] igb: add IGB_DCA instead of selecting INTEL_IOATDMA
References: <20081017180831.15639.50705.stgit@gitlost.lost>
In-Reply-To: <20081017180831.15639.50705.stgit@gitlost.lost>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: bunk@kernel.org, akpm@linux-foundation.org,
	e1000-devel@lists.sourceforge.net, tiwai@suse.de,
	netdev@vger.kernel.org, maciej.sosnowski@intel.com,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	brice@myri.com, dan.j.williams@intel.com, sam@ravnborg.org,
	davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jeff Kirsher wrote:
> Add a bool IGB_DCA defined to y if IGB and DCA are enabled, but IGB isn't y while DCA=m.  And thus remove the need to select INTEL_IOATDMA when IGB is enabled, so that non-x86 architectures can build the igb driver.
> Based on work/patch from Brice Goglin <brice@myri.com>
> 
> Signed-off-by: Jeff Kirsher <jeffrey.t.kirsher@intel.com>

applied
