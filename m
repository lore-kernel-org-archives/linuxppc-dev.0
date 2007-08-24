Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 3A7A8DDE47
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 07:47:13 +1000 (EST)
Date: Fri, 24 Aug 2007 14:47:11 -0700 (PDT)
Message-Id: <20070824.144711.18301866.davem@davemloft.net>
To: jchapman@katalix.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <46CF127D.1090609@katalix.com>
References: <200708241747.16592.ossthema@de.ibm.com>
	<20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
	<46CF127D.1090609@katalix.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, linuxppc-dev@ozlabs.org, akepner@sgi.com,
	meder@de.ibm.com, ossthema@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: James Chapman <jchapman@katalix.com>
Date: Fri, 24 Aug 2007 18:16:45 +0100

> Does hardware interrupt mitigation really interact well with NAPI?

It interacts quite excellently.

There was a long saga about this with tg3 and huge SGI numa
systems with large costs for interrupt processing, and the
fix was to do a minimal amount of interrupt mitigation and
this basically cleared up all the problems.

Someone should reference that thread _now_ before this discussion goes
too far and we repeat a lot of information and people like myself have
to stay up all night correcting the misinformation and
misunderstandings that are basically guarenteed for this topic :)
