Return-Path: <glppd-linuxppc64-dev@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E1C6DDF24
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Apr 2007 01:05:06 +1000 (EST)
Received: from root by ciao.gmane.org with local (Exim 4.43)
	id 1HbzqE-0004Yu-3L
	for linuxppc-dev@ozlabs.org; Thu, 12 Apr 2007 16:00:03 +0200
Received: from 10.8.185.213.dk-amb.res.sta.perspektivbredband.net
	([213.185.8.10]) by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 16:00:02 +0200
Received: from benny+usenet by
	10.8.185.213.dk-amb.res.sta.perspektivbredband.net with local
	(Gmexim 0.1 (Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Apr 2007 16:00:02 +0200
To: linuxppc-dev@ozlabs.org
From: Benny Amorsen <benny+usenet@amorsen.dk>
Subject: Re: [PATCH] Stop pmac_zilog from abusing 8250's device numbers.
Date: 11 Apr 2007 18:30:39 +0200
Message-ID: <m3tzvm6fgw.fsf@ursa.amorsen.dk>
References: <1175644642.10567.31.camel@shinybook.infradead.org>
	<20070403221002.GA13210@cynthia.pants.nu>
	<1175648051.10567.61.camel@shinybook.infradead.org>
	<20070403.181645.68159458.davem@davemloft.net>
	<20070404022828.5c9b97f3@the-village.bc.nu>
	<Pine.LNX.4.64.0704032307001.7802@mtl.rackplans.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@sea.gmane.org>
Cc: linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>>>> "GM" == Gerhard Mack <gmack@innerfire.net> writes:

GM> On Wed, 4 Apr 2007, Alan Cox wrote:
>> You don't get machines with 64 ethernet ports on add-in cards.
>> There are good reasons for the naming schemes in use.

GM> If they made them I'd build one.

Indeed, port density is disappointingly poor in modern servers. Do you
know any with more than 14 ports per U? (That's an MBX 1U server with
8 on-board and a 6-port expansion).


/Benny
