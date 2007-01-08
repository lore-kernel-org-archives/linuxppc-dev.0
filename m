Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 6FD72DDE33
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Jan 2007 08:04:30 +1100 (EST)
Date: Mon, 8 Jan 2007 15:04:17 -0600
From: Nathan Lynch <ntl@pobox.com>
To: Owen Stampflee <ostampflee@terrasoftsolutions.com>
Subject: Re: 2.6.20-rc4 Kernel Oops on Maple
Message-ID: <20070108210417.GA8122@localdomain>
References: <1168289034.2610.214.camel@darkside.terraplex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1168289034.2610.214.camel@darkside.terraplex.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Owen Stampflee wrote:
> I'm seeing both a sig 5 and a sig 11 in two backtraces during boot on a
> Maple-based board... both vanilla 2.6.17.13 and 2.6.18.1 work fine on
> this board.
> 
> Anyone have any ideas on what got broken?

http://patchwork.ozlabs.org/linuxppc/patch?id=8840
