Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6E898DDD01
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Feb 2007 11:27:38 +1100 (EST)
Subject: Re: [PATCH 0/4] spidernet: support for Celleb
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linas Vepstas <linas@austin.ibm.com>
In-Reply-To: <20070212234959.GF923@austin.ibm.com>
References: <200702070849.l178nvGC005341@toshiba.co.jp>
	<20070212234959.GF923@austin.ibm.com>
Content-Type: text/plain
Date: Tue, 13 Feb 2007 11:24:10 +1100
Message-Id: <1171326250.20192.48.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jgarzik@pobox.com,
	jim@jklewis.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-02-12 at 17:49 -0600, Linas Vepstas wrote:
> On Wed, Feb 07, 2007 at 05:49:50PM +0900, Ishizaki Kou wrote:
> > This is a revised spidernet patch set based on
> > netdev-2.6.git#upstream.
> 
> Tested this series of patches together with Jen's "version 3" patch,
> it worked for me. Code looks reasonable.  Thus
> 
> Acked-by: Linas Vepstas <linas@austin.ibm.com>
> 
> I'm somewhat unclear as to whethr I should be doing 
> 
> Signed-off-by: Linas Vepstas <linas@austin.ibm.com>

If the patch wasn't actually handled and passed-on by you or modified by
you, then no. Acked-by is the way to go.

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org> too while at
it.

Ben.
