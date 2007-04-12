Return-Path: <rdreier@cisco.com>
Received: from sj-iport-3.cisco.com (sj-iport-3-in.cisco.com [171.71.176.72])
	by ozlabs.org (Postfix) with ESMTP id 074B9DDF5E
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 01:34:49 +1000 (EST)
To: Benny Amorsen <benny+usenet@amorsen.dk>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
References: <1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403.181645.68159458.davem@davemloft.net>
	<20070404022828.5c9b97f3@the-village.bc.nu>
	<Pine.LNX.4.64.0704032307001.7802@mtl.rackplans.net>
	<m3tzvm6fgw.fsf@ursa.amorsen.dk>
From: Roland Dreier <rdreier@cisco.com>
Date: Thu, 12 Apr 2007 08:34:40 -0700
In-Reply-To: <m3tzvm6fgw.fsf@ursa.amorsen.dk> (Benny Amorsen's message of "11
	Apr 2007 18:30:39 +0200")
Message-ID: <adabqhtip2n.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

 > Indeed, port density is disappointingly poor in modern servers. Do you
 > know any with more than 14 ports per U? (That's an MBX 1U server with
 > 8 on-board and a 6-port expansion).

If you really need a ton of ports you could probably build a 1U server
with 2 * 2-port 10gig NICs, and use VLAN-capable switches with 10gig
and 1gig ports to fan out each 10gig link from your server to 10 1-gig
ports.  That would get you 40 ports of 1-gig from each server (plus
whatever the server has on board).

 - R.
