Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A90D3B7CA3
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:46:53 +1100 (EST)
Subject: Re: [PATCH 3/8] powerpc/cpm: Move CPMFCR_* defines into cpm.h
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091012164918.GC4578@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:46:40 -0600
Message-Id: <6C8EB548-0C0F-4559-A1B1-AE397305FD21@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164918.GC4578@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@ru.mvista.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Greg Kroah-Hartman <gregkh@suse.de>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	spi-devel-general@lists.sourceforge.net,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 12, 2009, at 11:49 AM, Anton Vorontsov wrote:

> The bits are generic to CPM devices, so let's move them to the
> common header file, so drivers won't need to privately reintroduce
> another bunch of the same bits (as we can't include cpm2.h header
> together with cpm1.h).
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
> arch/powerpc/include/asm/cpm.h  |   16 ++++++++++++++++
> arch/powerpc/include/asm/cpm2.h |    8 --------
> 2 files changed, 16 insertions(+), 8 deletions(-)

applied to next

- k
