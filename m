Return-Path: <ebs@ebshome.net>
Received: from gate.ebshome.net (gate.ebshome.net [208.106.21.240])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "gate.ebshome.net", Issuer "gate.ebshome.net" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 0D962DDE9F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 20:08:35 +1100 (EST)
Date: Sat, 12 Jan 2008 01:08:33 -0800
From: Eugene Surovegin <ebs@ebshome.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] ibm_newemac: Increase number of default rx-/tx-buffers
Message-ID: <20080112090833.GA29314@gate.ebshome.net>
References: <1199526609-12290-1-git-send-email-sr@denx.de>
	<20080111174822.GB17240@gate.ebshome.net>
	<1200089457.6896.65.camel@pasglop> <200801120826.53091.sr@denx.de>
	<1200124644.6896.99.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1200124644.6896.99.camel@pasglop>
Cc: netdev@vger.kernel.org, Stefan Roese <sr@denx.de>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Jan 12, 2008 at 06:57:24PM +1100, Benjamin Herrenschmidt wrote:
> 
> On Sat, 2008-01-12 at 08:26 +0100, Stefan Roese wrote:
> > 
> > We shouldn't make it too complicated. We can always select different
> > settings 
> > in the defconfig file. My thinking here is to better wast a little
> > memory 
> > with a potential performance improvement. Just me 0.02$
> 
> If it gets really critical, then we can move those settings to the
> device-tree.

Come on guys, it's not that critical. I guess I just don't trust a 
certain company :)

-- 
Eugene
