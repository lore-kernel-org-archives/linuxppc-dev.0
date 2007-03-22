Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id C3DCEDDFCF
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Mar 2007 04:57:19 +1100 (EST)
Date: Thu, 22 Mar 2007 12:57:12 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Chuck Meade <chuckmeade@mindspring.com>
Subject: Re: MPC83xx SDMR setup error
Message-Id: <20070322125712.2229ff99.kim.phillips@freescale.com>
In-Reply-To: <4602BD39.9020102@mindspring.com>
References: <460292FA.8050206@mindspring.com>
	<E9D1DC31-9730-4431-9414-0870FDD3EAF6@kernel.crashing.org>
	<4602BD39.9020102@mindspring.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 22 Mar 2007 13:30:33 -0400
Chuck Meade <chuckmeade@mindspring.com> wrote:

> 
> However, as I mention below, it is unclear whether the buffer alignment
> requirement is 64 bytes or 4Kbytes.  The code aligns the buffer to 64 bytes.

The rev.1 8360 manual changes the rev.0 manual's 64 bytes to a 4Kbytes alignment requirement, so it's probably best to go with 4KiB.

Kim
