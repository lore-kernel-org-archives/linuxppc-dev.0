Return-Path: <bdc@carlstrom.com>
Received: from electricrain.com (electricrain.com [207.7.145.10])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 28D9167A33
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Apr 2006 12:36:59 +1000 (EST)
From: "Brian D. Carlstrom" <bdc@carlstrom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17459.11188.362959.630416@zot.electricrain.com>
Date: Tue, 4 Apr 2006 19:30:12 -0700
To: "Yang Dehua" <yangdh@cableplus.com.cn>
Subject: xorg-7.0 freezes on gentoo ppc64 linux with 9800 card
In-Reply-To: <004301c65843$d561d710$6500a8c0@yangdh>
References: <004301c65843$d561d710$6500a8c0@yangdh>
Cc: linuxppc-dev@ozlabs.org
Reply-To: "Brian D. Carlstrom" <bdc@carlstrom.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Yang Dehua writes:
 > I just bought a mac 9800xt card to replace my 9600pro on my G5
 > running gentoo ppc64 linux(2006.0, 64-bit userland). The system
 > worked fine until I started xorg-7.0: the screen blacked and the
 > keyboard and mouse were not responding any more, so I had to shutdown
 > the machine. The same X config worked well with 9600pro card(64M).

I ran into this and posted a workaround about it here for fedora:
    http://lists.infradead.org/pipermail/fedora-ppc/2006-March/000816.html

I based this workaround based on the Ubuntu discussion here:
    https://launchpad.net/distros/ubuntu/+source/xserver-xorg-driver-ati/+bug/30426

Basically, Benjamin Herrenschmidt recommends "building the ati driver
from X.org ati-1-0-branch CVS branch". With that, I'm working in X
happily. I'll note that an alternative before that was to use the
"fbdev" driver instead of the "radeon".

-bri
