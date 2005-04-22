Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id B9C8667A6B
	for <linuxppc-dev@ozlabs.org>; Fri, 22 Apr 2005 10:17:45 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Colin Leroy <colin@colino.net>
In-Reply-To: <20050421200408.5361a5b3@jack.colino.net>
References: <20050421200408.5361a5b3@jack.colino.net>
Content-Type: text/plain
Date: Fri, 22 Apr 2005 10:17:14 +1000
Message-Id: <1114129034.18680.34.camel@gaston>
Mime-Version: 1.0
Cc: Takashi Iwai <tiwai@suse.de>, linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"debian-powerpc@lists.debian.org" <debian-powerpc@lists.debian.org>,
	Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 2.6.12-rc3] pmac: save master volume on sleep
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2005-04-21 at 20:04 +0200, Colin Leroy wrote:
> Hi,
> 
> Ben's patch that shutdowns master switch and restores it after
> resume ("pmac: Improve sleep code of tumbler driver") isn't enough here
> on an iBook (snapper chip).
> 
> The master switch is correctly saved and restored, but somehow
> tumbler_put_master_volume() gets called just after
> tumbler_set_master_volume() and sets mix->master_vol[*] to 0. So, on
> resuming, the master switch is reenabled, but the volume is set to 0.
> 
> Here's a patch that also saves and restores master_vol.
> Thanks,

Looks good.

Ben.
