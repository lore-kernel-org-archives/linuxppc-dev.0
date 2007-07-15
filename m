Return-Path: <SRS0+fe73469c4b12ee74a8d3+1421+infradead.org+hch@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id BCBE7DDDF9
	for <linuxppc-dev@ozlabs.org>; Sun, 15 Jul 2007 19:13:02 +1000 (EST)
Date: Sun, 15 Jul 2007 10:12:53 +0100
From: Christoph Hellwig <hch@infradead.org>
To: David Miller <davem@davemloft.net>
Subject: Re: [RFC 0/3] lro: Generic Large Receive Offload for TCP traffic
Message-ID: <20070715091253.GA15790@infradead.org>
References: <200707111621.24852.ossthema@de.ibm.com>
	<20070714.235748.02297780.davem@davemloft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070714.235748.02297780.davem@davemloft.net>
Cc: tklein@de.ibm.com, themann@de.ibm.com, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, raisch@de.ibm.com,
	linuxppc-dev@ozlabs.org, ossthema@de.ibm.com, meder@de.ibm.com,
	stefan.roscher@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jul 14, 2007 at 11:57:48PM -0700, David Miller wrote:
> only request is to make this thing able to handle ipv6 as
> well even if no current chips could facilitate that yet.

I'm not sure that's a good idea.  If current chips can't handle ipv6
lro there is no way to actually test it and the code will surely bitrot.
