Return-Path: <jchapman@katalix.com>
Received: from ptb-relay02.plus.net (ptb-relay02.plus.net [212.159.14.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCD4D67A7D
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Feb 2005 02:50:49 +1100 (EST)
Message-ID: <421DF7D0.2050803@katalix.com>
Date: Thu, 24 Feb 2005 15:50:40 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
References: <421CEC19.2010703@katalix.com>
	<20050223222534.GM345@smtp.west.cox.net>
	<421D97FE.4080100@katalix.com>
	<20050224141809.GP345@smtp.west.cox.net>
In-Reply-To: <20050224141809.GP345@smtp.west.cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org
Subject: Re: PATCH: add ppc PVR register values for 7447A and 7457 CPUs
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Tom Rini wrote:

> Is there something you can't get from cur_cpu_spec[0] ?  That's why all
> of the PVR definitions _should_ be unneeded now.

No, I'll use cur_cpu_spec[]. Thanks

-- 
James Chapman
PGP key : http://www.katalix.com/~jchapman/pgpkey.txt
