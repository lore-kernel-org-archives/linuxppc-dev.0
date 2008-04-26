Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3F7E8DDE1F
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 17:11:04 +1000 (EST)
Date: Sat, 26 Apr 2008 00:11:02 -0700 (PDT)
Message-Id: <20080426.001102.65527296.davem@davemloft.net>
To: kevdig@hypersurf.com
Subject: Re: get_cycles()
From: David Miller <davem@davemloft.net>
In-Reply-To: <4812DFA3.6090106@hypersurf.com>
References: <4812DFA3.6090106@hypersurf.com>
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

From: Kevin Diggs <kevdig@hypersurf.com>
Date: Sat, 26 Apr 2008 00:54:11 -0700

> 	Anyone know how to turn get_cycles() into an actual time in a module? 
> ppc_tb_freq does not seem to be exported?

You should really be using ktime_t and associated interfaces.
