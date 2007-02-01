Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 400B3DDDF8
	for <linuxppc-dev@ozlabs.org>; Thu,  1 Feb 2007 15:30:30 +1100 (EST)
Date: Wed, 31 Jan 2007 20:29:09 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 0/6] MSI portability cleanups
Message-ID: <20070201042909.GD3648@kroah.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<m1hcubq6re.fsf@ebiederm.dsl.xmission.com>
	<1170015805.26655.15.camel@localhost.localdomain>
	<45BD0BDC.40205@garzik.org>
	<m1bqkiq25v.fsf@ebiederm.dsl.xmission.com>
	<1170022154.26655.63.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1170022154.26655.63.camel@localhost.localdomain>
Cc: Tony Luck <tony.luck@intel.com>, Grant Grundler <grundler@parisc-linux.org>,
	Jeff Garzik <jeff@garzik.org>, "David S. Miller" <davem@davemloft.net>,
	linux-kernel@vger.kernel.org,
	Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	"Eric W. Biederman" <ebiederm@xmission.com>,
	shaohua.li@intel.com, Ingo Molnar <mingo@elte.hu>,
	linux-pci@atrey.karlin.mff.cuni.cz, Brice Goglin <brice@myri.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 29, 2007 at 09:09:14AM +1100, Benjamin Herrenschmidt wrote:
> 
> If we followed that "only do incrementental changes" rule all the time,
> imagine in what state would be our USB stack today since we couldn't
> have dropped in Linus replacement one ...

Bad example, that is not what happened at all.  There was not an
in-kernel USB stack when Linus wrote his.  Inaky had his
all-singing-all-dancing stack outside of the tree, and no one was really
helping out with it.

Only when Linus added his code to mainline did we all jump on it and
_incrementally_ improve it to what we have today.

So, in a way, you just proved that we need to do this in an incremental
fashion, which is what I was also saying all along :)

thanks,

greg k-h
