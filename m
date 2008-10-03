Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3D9F6DDF0D
	for <linuxppc-dev@ozlabs.org>; Sat,  4 Oct 2008 02:14:28 +1000 (EST)
Message-Id: <01391274-EE23-4DE0-BEA9-BC2BCBD16789@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20081003160814.GA26115@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH v2] powerpc/83xx: don't probe broken PCI on mpc837x_mds
	boards
Date: Fri, 3 Oct 2008 11:14:18 -0500
References: <20081002151852.GA8823@oksana.dev.rtsoft.ru>
	<504AAC96-2F7E-4A06-B544-1F2169BB2176@kernel.crashing.org>
	<20081003160814.GA26115@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 3, 2008, at 11:08 AM, Anton Vorontsov wrote:

> In the standalone setup the board's CPLD disables the PCI internal
> arbiter, thus any access to the PCI bus will hang the board.
>
> When there is no PCI arbiter on the bus the u-boot adds
> status = "broken (no arbiter)" property into the PCI controller's
> node, and so marks the PCI controller as unavailable.
>
> Signed-off-by: Anton Vorontsov <avorontsov@ru.mvista.com>
> ---
>
> On Thu, Oct 02, 2008 at 02:48:44PM -0500, Kumar Gala wrote:
>> Can you add to the commit message something about using the 'status
>> field in the device tree to determine if the pci controller is
>> available'
>
> Something like this?
>
> Thanks,

yes, but should we just have "status = disabled" since that is the  
effect?

- k
