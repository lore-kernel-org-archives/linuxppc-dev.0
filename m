Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F004FDDDDB
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Nov 2007 07:09:49 +1100 (EST)
Message-Id: <BBEA4B9C-5A01-4BEB-8A22-7F79224CA31A@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Olof Johansson <olof@lixom.net>
In-Reply-To: <20071116200510.GA18481@lixom.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] Add SPRN for Embedded registers specified in
	PowerISA 2.04
Date: Fri, 16 Nov 2007 14:09:43 -0600
References: <Pine.LNX.4.64.0711161358280.24588@blarg.am.freescale.net>
	<20071116200510.GA18481@lixom.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 16, 2007, at 2:05 PM, Olof Johansson wrote:

> Hi,
>
>
> On Fri, Nov 16, 2007 at 01:59:03PM -0600, Kumar Gala wrote:
>> +#define SPRN_SPRG8	0x25C	/* Special Purpose Register General 8 */
>> +#define SPRN_SPRG9	0x25D	/* Special Purpose Register General 8 */
>
> Cut and paste error in comment :)

thanks, git-commit --amend fixed ;)

- k
