Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B5DE4DDF51
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 18:12:10 +1100 (EST)
Date: Wed, 21 Jan 2009 23:12:10 -0800 (PST)
Message-Id: <20090121.231210.261407216.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: perf_counter vs. oprofile
From: David Miller <davem@davemloft.net>
In-Reply-To: <18808.6885.373593.934704@cargo.ozlabs.ibm.com>
References: <20090121.212634.237965647.davem@davemloft.net>
	<18808.6885.373593.934704@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Thu, 22 Jan 2009 18:06:13 +1100

> Out of curiosity, what ppc hardware are you using perf_counters on?
> A G5?

An UltraSPARC-IIIi :-)

I just wanted to make sure you realized the conflict, and you
obviously do.
