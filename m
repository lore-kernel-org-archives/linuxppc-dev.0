Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 53FA3DDE45
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Dec 2007 12:58:16 +1100 (EST)
Subject: Re: [PATCH 1/3] ps3: vuart: fix error path locking
From: Daniel Walker <dwalker@mvista.com>
To: Andrew Morton <akpm@linux-foundation.org>
In-Reply-To: <20071218171050.5bf220fa.akpm@linux-foundation.org>
References: <20071213003028.676998182@mvista.com>
	<4760922C.2060908@am.sony.com>
	<20071218171050.5bf220fa.akpm@linux-foundation.org>
Content-Type: text/plain
Date: Tue, 18 Dec 2007 17:54:48 -0800
Message-Id: <1198029288.2716.25.camel@imap.mvista.com>
Mime-Version: 1.0
Cc: matthias.kaehlcke@gmail.com, linux-kernel@vger.kernel.org, linux@bohmer.net,
	linuxppc-dev@ozlabs.org, mingo@elte.hu, kjwinchester@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-12-18 at 17:10 -0800, Andrew Morton wrote:

> is correct.  Although not exactly a thing of beauty.

This isn't the worst I've seen ;( .. Do you think the ending should fall
through instead of having two returns?

Daniel
