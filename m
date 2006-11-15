Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4892967D6F
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Nov 2006 05:09:57 +1100 (EST)
Date: Wed, 15 Nov 2006 19:09:48 +0100
From: Christoph Hellwig <hch@lst.de>
To: Geoff Levand <geoffrey.levand@am.sony.com>
Subject: Re: [PATCH 14/16] powerpc: add ps3 platform OS params support
Message-ID: <20061115180948.GD18856@lst.de>
References: <4554DB20.9020200@am.sony.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4554DB20.9020200@am.sony.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Nov 10, 2006 at 12:03:44PM -0800, Geoff Levand wrote:
> Add support to access the parameter data from the ps3pf other OS area of flash
> memory.  The parameter data mainly holds user preferences like static ip
> address, etc.

So what's this code doing it?  You'd need some kind of sysfs or similar
interface to actually export it to the user.
