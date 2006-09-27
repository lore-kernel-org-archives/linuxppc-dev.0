Return-Path: <SRS0+b3bad606449a68d80a45+1130+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 56BF2679E1
	for <linuxppc-dev@ozlabs.org>; Wed, 27 Sep 2006 22:49:51 +1000 (EST)
Subject: Re: [PATCH] Use check_legacy_ioport() for ISAPnP
From: David Woodhouse <dwmw2@infradead.org>
To: Olaf Hering <olaf@aepfle.de>
In-Reply-To: <20060927081838.GA5984@aepfle.de>
References: <1159341535.3309.108.camel@pmac.infradead.org>
	<20060927081838.GA5984@aepfle.de>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 13:49:45 +0100
Message-Id: <1159361385.3309.118.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2006-09-27 at 10:18 +0200, Olaf Hering wrote:
> Isnt that fixed by my other patch which was merged into -mm today?

Hm, wasn't aware of that.

/me looks...

No, your patch seems to change pnpbios, not isapnp. Which is odd, since
pnpbios is x86-only anyway.

And did you fix the case of PCI parallel ports? We only want to do the
check_legacy_ioport() thing for the 'default' built-in ports, not for
all ports.

-- 
dwmw2
