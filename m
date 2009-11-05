Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BE067100C72
	for <linuxppc-dev@ozlabs.org>; Fri,  6 Nov 2009 00:47:01 +1100 (EST)
Subject: Re: [PATCH 4/8] powerpc/qe&cpm: Implement static inline stubs for
	non-QE/CPM builds
Mime-Version: 1.0 (Apple Message framework v1076)
Content-Type: text/plain; charset=us-ascii; format=flowed; delsp=yes
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20091012164920.GD4578@oksana.dev.rtsoft.ru>
Date: Thu, 5 Nov 2009 07:46:48 -0600
Message-Id: <F65088B7-CBE6-4CD5-8715-E3C504C99A6E@kernel.crashing.org>
References: <20091012164841.GA32214@oksana.dev.rtsoft.ru>
	<20091012164920.GD4578@oksana.dev.rtsoft.ru>
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

> This is needed to avoid ugly #ifdefs in drivers. Also update  
> fsl_qe_udc
> driver so that now it doesn't define its own versions that cause build
> breakage when the generic stubs are used.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
> ---
> arch/powerpc/include/asm/cpm.h  |   44 ++++++++++++++++++++++++++++++ 
> +++++++++
> arch/powerpc/include/asm/qe.h   |   11 ++++++++-
> drivers/usb/gadget/fsl_qe_udc.h |   15 -------------
> 3 files changed, 54 insertions(+), 16 deletions(-)

applied to next

- k
