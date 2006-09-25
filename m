Return-Path: <aris@cathedrallabs.org>
Received: from tinc.cathedrallabs.org (tinc.cathedrallabs.org [72.9.252.66])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D171D67A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Sep 2006 08:31:14 +1000 (EST)
Date: Mon, 25 Sep 2006 19:30:58 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Brad Boyer <flar@allandria.com>
Subject: Re: [PATCH] adbhid: make KEY_SYSRQ configurable on ADB based machines
Message-ID: <20060925223057.GA23526@cathedrallabs.org>
References: <20060808154937.GC3363@cathedrallabs.org>
	<20060920134459.GC23803@cathedrallabs.org>
	<20060920053656.GA28326@cynthia.pants.nu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060920053656.GA28326@cynthia.pants.nu>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Brad,
> The only thing I see is that each ADB keyboard device will have an entry
> in sysfs to change the sysrq key, but they will all set the same global.
> It's a little misleading, but I don't think it's a major issue. And
> before anyone asks, I have in fact had multiple ADB keyboards attached
> to a single machine. It was useful for multi-player games.
what about this updated patch?

-- 
Aristeu
