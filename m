Return-Path: <rdreier@cisco.com>
Received: from sj-iport-4.cisco.com (sj-iport-4.cisco.com [171.68.10.86])
	by ozlabs.org (Postfix) with ESMTP id 0562A67CF4
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 16 Nov 2006 12:36:24 +1100 (EST)
To: mporter@kernel.crashing.org
Subject: Re: [PATCH v2 -- fixed changelog] [POWERPC] Add support for Rev. B of
	PowerPC 440SPe
References: <adalkmf44eu.fsf@cisco.com> <adaac2v2d2g.fsf@cisco.com>
	<20061114090102.GA16520@gate.ebshome.net> <adapsbowdgg.fsf@cisco.com>
	<20061116011453.GA19241@gate.ebshome.net> <ada3b8kuqzn.fsf@cisco.com>
	<20061116012631.GA27724@gate.ebshome.net>
From: Roland Dreier <rdreier@cisco.com>
Date: Wed, 15 Nov 2006 17:36:23 -0800
In-Reply-To: <20061116012631.GA27724@gate.ebshome.net> (Eugene Surovegin's
	message of "Wed, 15 Nov 2006 17:26:31 -0800")
Message-ID: <aday7qctboo.fsf@cisco.com>
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

 > OK, I was just wanted to make sure you were aware that mfdcr/mtdcr 
 > supported run-time specified DCR number (from that code it wasn't 
 > clear).

I actually didn't until you pointed it out -- mfdcr looks enough like
assembly to confuse my small brain, and I guess I'm way behind the
times (since the support for run-time numbers predates the beginning
of git history, so it's been a _long_ time).

 - R.
