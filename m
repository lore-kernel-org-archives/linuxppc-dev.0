Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E48C9DDDDB
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Nov 2007 08:01:21 +1100 (EST)
Message-Id: <B82E6C31-8BB7-4348-9426-B18A971172A9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20071120175416.GA4389@loki.buserror.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Emulate isel (Integer Select) instruction
Date: Tue, 20 Nov 2007 15:01:11 -0600
References: <Pine.LNX.4.64.0711192135460.24923@blarg.am.freescale.net>
	<20071120175416.GA4389@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 20, 2007, at 11:54 AM, Scott Wood wrote:

> On Mon, Nov 19, 2007 at 09:36:57PM -0600, Kumar Gala wrote:
>> isel (Integer Select) is a new user space instruction in the
>> PowerISA 2.04 spec.  Not all processors implement it so lets emulate
>> to ensure code built with isel will run everywhere.
>
> Given that the instruction is meant to be a performance enhancement,
> we should probably warn the first few times it's emulated, so the user
> knows they should change their toolchain setup if possible.

The same is true of mcrxr, popcntb, and possibly string ld/st.

Feel free to submit a patch that warns about their usage.

- k
