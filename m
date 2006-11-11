Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1883E67F42
	for <linuxppc-dev@ozlabs.org>; Sat, 11 Nov 2006 22:22:45 +1100 (EST)
Date: Sat, 11 Nov 2006 12:22:39 +0100
From: Christoph Hellwig <hch@lst.de>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 8/16] powerpc: add ps3 platform hvcalls
Message-ID: <20061111112239.GB24288@lst.de>
References: <4554DAD7.2090709@am.sony.com> <200611110313.40940.arnd@arndb.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200611110313.40940.arnd@arndb.de>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Nov 11, 2006 at 03:13:40AM +0100, Arnd Bergmann wrote:
> On Friday 10 November 2006 21:02, Geoff Levand wrote:
> > Adds the ps3pf hvcalls.
> > 
> > Signed-off-by: Geoff Levand <geoffrey.levand@am.sony.com>
> 
> This one reminds of the inline hcall abstraction layer I did
> some time ago. The implementation in your patch is a lot
> less elegant than both the pseries in its current incarnation
> and the one that I did (IMHO). Any opinions on how we should
> proceed here?

Please try to reuse Arnd's code as much as possible.  What's in
this patch is more than ugly.
