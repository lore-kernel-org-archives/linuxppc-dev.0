Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id E808BDDDE9
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 16:57:47 +1000 (EST)
Date: Sat, 14 Jul 2007 23:57:48 -0700 (PDT)
Message-Id: <20070714.235748.02297780.davem@davemloft.net>
To: ossthema@de.ibm.com
Subject: Re: [RFC 0/3] lro: Generic Large Receive Offload for TCP traffic
From: David Miller <davem@davemloft.net>
In-Reply-To: <200707111621.24852.ossthema@de.ibm.com>
References: <200707111621.24852.ossthema@de.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	raisch@de.ibm.com, meder@de.ibm.com, stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


I think this work is great.  Thanks for doing it.

Besides the fixups Evgeniy has selected, and the suggestion
to receive into pages to cut down allocation costs, my
only request is to make this thing able to handle ipv6 as
well even if no current chips could facilitate that yet.
