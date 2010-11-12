Return-Path: <jkenisto@linux.vnet.ibm.com>
Received: from e3.ny.us.ibm.com (e3.ny.us.ibm.com [32.97.182.143])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e3.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC9E9B7135
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Nov 2010 11:08:20 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e3.ny.us.ibm.com (8.14.4/8.13.1) with ESMTP id oABNoQNY031101
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 18:50:26 -0500
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	oAC07kY6475440
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 19:07:46 -0500
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
	by d03av04.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP
	id oAC07jEZ018703
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Nov 2010 17:07:46 -0700
Subject: Re: Can't boot benh/powerpc.git kernel
From: Jim Keniston <jkenisto@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1289426817.2147.1403.camel@pasglop>
References: <1289418856.2983.23.camel@localhost>
	<1289426817.2147.1403.camel@pasglop>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 11 Nov 2010 16:07:44 -0800
Message-ID: <1289520464.4752.12.camel@localhost>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-11-11 at 09:06 +1100, Benjamin Herrenschmidt wrote:
> On Wed, 2010-11-10 at 11:54 -0800, Jim Keniston wrote:
> > I got Ben's linux/kernel/git/benh/powerpc.git source and built it
> > (.config file attached*).  It hangs on boot.  When I boot it with
> > loglevel=8, its last words are:
> 
> First, please try with Linus upstream. The "master" branch in my git
> tree is quite stale, and my next and merge branch are too at the moment
> as I'm still travelling. All our current stuff was merged during the
> last merge window so there's nothing "new" for you to pickup in my tree
> at the moment :-)
> 
> If the problem still occurs, I'll have a look next week.
> 
> Cheers,
> Ben.

I built from Linus's git tree, and that kernel doesn't boot, either.
(It doesn't hang, but rather panics during boot.  I can provide a
console log if you like.)

v2.6.36 and v2.6.37-rc1 boot fine for me.  I'll post my nvram-related
patches against v2.6.37-rc1.

Jim
