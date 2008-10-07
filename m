Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B98EDDDEDD
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 23:32:53 +1100 (EST)
Message-Id: <55CEF712-500E-43CF-846C-5F1A7957C917@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081006170839.GA21726@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v3] powerpc/83xx: don't probe broken PCI on mpc837x_mds
	boards
Date: Tue, 7 Oct 2008 07:32:32 -0500
References: <20081002151852.GA8823@oksana.dev.rtsoft.ru>
	<504AAC96-2F7E-4A06-B544-1F2169BB2176@kernel.crashing.org>
	<20081003160814.GA26115@oksana.dev.rtsoft.ru>
	<01391274-EE23-4DE0-BEA9-BC2BCBD16789@kernel.crashing.org>
	<20081003162709.GB31740@oksana.dev.rtsoft.ru>
	<D4BCDA24-B860-4D21-8115-2A22CD01B480@kernel.crashing.org>
	<20081006170839.GA21726@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 6, 2008, at 12:08 PM, Anton Vorontsov wrote:

> In the standalone setup the board's CPLD disables the PCI internal
> arbiter, thus any access to the PCI bus will hang the board.
>
> The common way to disable particular devices in the device tree is to
> put the "status" property with any value other than "ok" or "okay"
> into the device node we want to disable.
>
> So, when there is no PCI arbiter on the bus the u-boot adds status =
> "broken (no arbiter)" property into the PCI controller's node, and so
> marks the PCI controller as unavailable.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---

applied

- k
