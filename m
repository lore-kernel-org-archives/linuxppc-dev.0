Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17209.817.732159.375607@cargo.ozlabs.ibm.com>
Date: Tue, 27 Sep 2005 18:30:41 +1000
From: Paul Mackerras <paulus@samba.org>
To: Christoph Hellwig <hch@lst.de>
In-Reply-To: <20050927082324.GA11437@lst.de>
References: <17208.37250.577664.621993@cargo.ozlabs.ibm.com>
	<20050927082324.GA11437@lst.de>
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: Starting the arch/powerpc merge
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Christoph Hellwig writes:

> What about just dropping POWER3/4 support in 32bit mode?

Yes... I'm getting very close to deciding to do that.  In fact POWER3
isn't too bad, since it still has BATs, but POWER4/PPC970 would be
tricky.

Does anyone on these lists have any major objections if we drop
support for 32-bit kernels on POWER3 and POWER4/PPC970?

Paul.
