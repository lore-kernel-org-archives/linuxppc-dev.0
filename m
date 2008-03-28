Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6686BDDE20
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Mar 2008 15:22:57 +1100 (EST)
Date: Thu, 27 Mar 2008 23:31:41 -0500
From: Olof Johansson <olof@lixom.net>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] fsldma: The MPC8377MDS board device tree node for
	fsldma driver
Message-ID: <20080328043141.GA24022@lixom.net>
References: <1206517356-11209-1-git-send-email-wei.zhang@freescale.com>
	<1206517356-11209-2-git-send-email-wei.zhang@freescale.com>
	<e9c3a7c20803271237x1b2c3a2ci6837c5e2d5288c95@mail.gmail.com>
	<9D668111-9774-4D45-944E-3C3C0EE47A09@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9D668111-9774-4D45-944E-3C3C0EE47A09@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org, Dan Williams <dan.j.williams@intel.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Mar 27, 2008 at 09:23:54PM -0500, Kumar Gala wrote:

>> I think this patch should probably go through the powerpc tree, or
>> -mm.  I'll pick up the ones that touch either drivers/dma or
>> crypto/async_tx.

It's a good idea to cc all fsldma patches to linuxppc-dev when they're
posted too, none of them have been so they have been missing review from
the powerpc crowd that didn't catch them on lkml.


-Olof
