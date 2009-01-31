Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id A4B23DE161
	for <linuxppc-dev@ozlabs.org>; Sat, 31 Jan 2009 19:50:05 +1100 (EST)
Date: Sat, 31 Jan 2009 00:50:00 -0800 (PST)
Message-Id: <20090131.005000.75318985.davem@davemloft.net>
To: sachinp@in.ibm.com
Subject: Re: [Patch] 2.6.29-rc3-git2 - Fix net/ipv6/ip6mr.o build break
From: David Miller <davem@davemloft.net>
In-Reply-To: <4983EEE3.3080208@in.ibm.com>
References: <4983EEE3.3080208@in.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: yoshfuji@linux-ipv6.org, linuxppc-dev@ozlabs.org, mel@csn.ul.ie,
	linux-kernel@vger.kernel.org, kamalesh@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Thanks for the report, Dave Jones already posted this fix
(CC:'d to the correct location, netdev@vger.kernel.org)
