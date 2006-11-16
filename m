Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id B597367CD6
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 12:20:30 +1100 (EST)
To: mporter@kernel.crashing.org
Subject: Re: [PATCH v2 -- fixed changelog] [POWERPC] Add support for Rev. B of
	PowerPC 440SPe
References: <adalkmf44eu.fsf@cisco.com> <adaac2v2d2g.fsf@cisco.com>
	<20061114090102.GA16520@gate.ebshome.net> <adapsbowdgg.fsf@cisco.com>
	<20061116011453.GA19241@gate.ebshome.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Nov 2006 17:20:28 -0800
In-Reply-To: <20061116011453.GA19241@gate.ebshome.net> (Eugene Surovegin's
	message of "Wed, 15 Nov 2006 17:14:54 -0800")
Message-ID: <ada3b8kuqzn.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

 > I think look-up tables are fine. It's not a fast path, is it?

Nope, that would be fine.  I'll definitely cut down on the code
duplication -- I'm just not sure what will end up being cleanest.  I
don't see that much difference between a switch and a look-up table
for finding the base DCR index for a particular port.
