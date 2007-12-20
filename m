Return-Path: <dwalker@mvista.com>
Received: from gateway-1237.mvista.com (gateway-1237.mvista.com
	[63.81.120.158]) by ozlabs.org (Postfix) with ESMTP id 44625DDE3B
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Dec 2007 06:32:49 +1100 (EST)
Subject: Re: [PATCH 1/3] ps3: vuart: fix error path locking
From: Daniel Walker <dwalker@mvista.com>
To: Geoff Levand <geoffrey.levand@am.sony.com>
In-Reply-To: <47688A5A.1090902@am.sony.com>
References: <20071213003028.676998182@mvista.com>
	<4760922C.2060908@am.sony.com>
	<20071218171050.5bf220fa.akpm@linux-foundation.org>
	<47688A5A.1090902@am.sony.com>
Content-Type: text/plain
Date: Thu, 20 Dec 2007 11:32:25 -0800
Message-Id: <1198179145.10713.9.camel@imap.mvista.com>
Mime-Version: 1.0
Cc: matthias.kaehlcke@gmail.com, linux-kernel@vger.kernel.org, linux@bohmer.net,
	linuxppc-dev@ozlabs.org, kjwinchester@gmail.com,
	Andrew Morton <akpm@linux-foundation.org>, mingo@elte.hu
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 2007-12-18 at 19:04 -0800, Geoff Levand wrote:

> Unfortunately there wasn't enough context in the patch to see
> that there is a down() earlier in the routine, and that the patch
> does indeed remove an incorrectly placed down().  Here is the
> entire routine, marked with what the patch removes.
> 

Andrew have you had a chance to review this?

Daniel
