Return-Path: <panto@intracom.gr>
Received: from mailserv.intranet.gr (mailserv.intranet.GR [146.124.14.106])
	by ozlabs.org (Postfix) with ESMTP id CDE9C67B15
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 21:59:04 +1000 (EST)
Received: from mailserv.intranet.gr (localhost [127.0.0.1])
	by mailserv.intranet.gr (8.13.1/8.13.1) with ESMTP id j3PC3PoD003595
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 25 Apr 2005 15:03:27 +0300 (EEST)
Message-ID: <426CD83A.6070205@intracom.gr>
Date: Mon, 25 Apr 2005 14:44:58 +0300
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050424225124.E7314C1510@atlas.denx.de>
In-Reply-To: <20050424225124.E7314C1510@atlas.denx.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: v2.6 performance slowdown on MPC8xx: Measuring TLB cache misses
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> Dear Marcelo,
> 

[depressing data snipped]

> 
> Wolfgang Denk
> 

Well it's a mess alright.

Unfortunately we cannot declare that we'll stay on 2.4 forever.

Several subsystems *MTD gough* do not support latest hw, or
the developers have moved on to 2.6 full time, refusing to
bother with 2.4 anymore.

Can we make an effort to pinpoint the performance
bottlenecks & re-implement the affected areas sanely?

The -tiny patchset is a start, but frankly I don't think it's
code/data footprint that it's the problem.

IMHO it's not just the small embedded systems that have been
affected; just on them the effects are more obvious.

So what do you all think?

Regards

Pantelis
