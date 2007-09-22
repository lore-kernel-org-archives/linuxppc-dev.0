Return-Path: <hch@lst.de>
Received: from mail.lst.de (verein.lst.de [213.95.11.210])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E57AADDDFA
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Sep 2007 19:56:15 +1000 (EST)
Date: Sat, 22 Sep 2007 11:55:46 +0200
From: Christoph Hellwig <hch@lst.de>
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 1/2] qemu platform, v2
Message-ID: <20070922095546.GA14185@lst.de>
References: <boot-8-00.miltonm@bga.com> <qemu-8-01.miltonm@bga.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <qemu-8-01.miltonm@bga.com>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Rob Landley <rob@landley.net>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Sep 21, 2007 at 06:08:31PM -0500, Milton Miller wrote:
> Here is the second rev of patches to boot a arch powerpc kernel on
> qemu with the prep architecture.

So if this is supposed to be prep why do you need additional kernel
support?  And if you really needed why isn't it under platforms/prep?
