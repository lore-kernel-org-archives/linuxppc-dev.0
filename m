Return-Path: <jim@jklewis.com>
Received: from omta01.suddenlink.net (omta01-pub.suddenlink.net
	[208.180.40.73]) by ozlabs.org (Postfix) with ESMTP id 114F367BEF
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 17:46:30 +1100 (EST)
Subject: Re: [PATCH 2/14] Spidernet add net_ratelimit to suppress long output
From: Jim Lewis <jim@jklewis.com>
To: michael@ellerman.id.au
In-Reply-To: <1166052679.6838.1.camel@concordia.ozlabs.ibm.com>
References: <20061213210010.GR4329@austin.ibm.com>
	<20061213210825.GB1915@austin.ibm.com>
	<1166052679.6838.1.camel@concordia.ozlabs.ibm.com>
Content-Type: text/plain
Date: Thu, 14 Dec 2006 00:13:19 -0600
Message-Id: <1166076799.21877.15.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Andrew Morton <akpm@osdl.org>, Arnd Bergmann <arnd@arndb.de>,
	netdev@vger.kernel.org, Christoph Hellwig <hch@infradead.org>,
	linuxppc-dev@ozlabs.org, Jens Osterkamp <Jens.Osterkamp@gmx.de>,
	jgarzik@pobox.com
Reply-To: jim@jklewis.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


 It is in the LTC Bugzilla. I just checked and it is still there :)

Jim


On Thu, 2006-12-14 at 10:31 +1100, Michael Ellerman wrote:
> On Wed, 2006-12-13 at 15:08 -0600, Linas Vepstas wrote:
> > This patch adds net_ratelimit to many of the printks in order to
> > limit extraneous warning messages (created in response to Bug 28554).
> 
> Bug 28554 in which bug tracking system? I can't find it in LTC or
> kernel.org bugzilla.
> 
> cheers
> 
