Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 52F09DDDEC
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Jan 2008 08:54:53 +1100 (EST)
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
In-Reply-To: <20080105154805.118eb3d1@vader.jdub.homelinux.org>
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<1199528388.7291.55.camel@pasglop> <200801051338.17957.sr@denx.de>
	<1199566386.7291.58.camel@pasglop>
	<20080105154805.118eb3d1@vader.jdub.homelinux.org>
Content-Type: text/plain
Date: Sun, 06 Jan 2008 08:54:28 +1100
Message-Id: <1199570068.7291.65.camel@pasglop>
Mime-Version: 1.0
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2008-01-05 at 15:48 -0600, Josh Boyer wrote:
> No need for a defconfig update patch.  Paul or I usually do a general
> defconfig update for most boards before the next kernel version.  This
> will get picked up then.

Will it ? I think the defconfigs will stick to the old value.

Ben.
