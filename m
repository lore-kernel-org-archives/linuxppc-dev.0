Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id B8256DDF49
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Aug 2007 07:44:37 +1000 (EST)
Date: Fri, 24 Aug 2007 14:44:36 -0700 (PDT)
Message-Id: <20070824.144436.59664160.davem@davemloft.net>
To: dlstevens@us.ibm.com
Subject: Re: RFC: issues concerning the next NAPI interface
From: David Miller <davem@davemloft.net>
In-Reply-To: <OF0002C3DB.2E4C4A38-ON88257341.005B1253-88257341.005C7C2A@us.ibm.com>
References: <20070824085203.42f4305c@freepuppy.rosehill.hemminger.net>
	<OF0002C3DB.2E4C4A38-ON88257341.005B1253-88257341.005C7C2A@us.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: tklein@de.ibm.com, themann@de.ibm.com, stefan.roscher@de.ibm.com,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
	raisch@de.ibm.com, netdev-owner@vger.kernel.org,
	linuxppc-dev@ozlabs.org, akepner@sgi.com, meder@de.ibm.com,
	ossthema@de.ibm.com, shemminger@linux-foundation.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: David Stevens <dlstevens@us.ibm.com>
Date: Fri, 24 Aug 2007 09:50:58 -0700

>         Problem is if it increases rapidly, you may drop packets
> before you notice that the ring is full in the current estimated
> interval.

This is one of many reasons why hardware interrupt mitigation
is really needed for this.
