Return-Path: <gregkh@suse.de>
Received: from mx1.suse.de (cantor.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id F2ED9DE147
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 09:10:58 +1100 (EST)
Date: Thu, 25 Jan 2007 14:10:01 -0800
From: Greg KH <greg@kroah.com>
To: Roland Dreier <rdreier@cisco.com>
Subject: Re: [RFC/PATCH 5/16] Ops based MSI implementation
Message-ID: <20070125221001.GA5946@kroah.com>
References: <1169714047.65693.647693675533.qpush@cradle>
	<20070125083411.5D935DE2FD@ozlabs.org>
	<20070125215209.GA3126@kroah.com> <adahcueoj8o.fsf@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <adahcueoj8o.fsf@cisco.com>
Cc: Kyle McMartin <kyle@parisc-linux.org>, linuxppc-dev@ozlabs.org,
	Brice Goglin <brice@myri.com>, shaohua.li@intel.com,
	linux-pci@atrey.karlin.mff.cuni.cz,
	"David S. Miller" <davem@davemloft.net>,
	"Eric W. Biederman" <ebiederm@xmission.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jan 25, 2007 at 02:05:11PM -0800, Roland Dreier wrote:
>  > Are you sure of the "any later version" part?
> 
> The command
> 
>     git grep "at your option) any later version"
> 
> finds more than 3000 matching files in my kernel source tree, so I
> think existing practice shows it's fine if someone wants to license
> a file for kernel inclusion that way.

Oh, I'm not saying that it isn't acceptable, just pointing it out so
that the poster thinks about it, instead of just cut-and-pasting it from
somewhere else.  Most companies today have policies about this wording
that the developer probably needs to be aware of.

Especially given the state of the current GPLv3 license wording, but
that's another email thread for another time :)

thanks,

greg k-h
