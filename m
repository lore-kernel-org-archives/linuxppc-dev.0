Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18426.4779.937007.883268@cargo.ozlabs.ibm.com>
Date: Mon, 7 Apr 2008 22:25:15 +1000
From: Paul Mackerras <paulus@samba.org>
To: David Miller <davem@davemloft.net>
Subject: Re: Patches added to powerpc.git powerpc-next and master branches
In-Reply-To: <20080406.232220.69225114.davem@davemloft.net>
References: <18425.46732.651483.504040@cargo.ozlabs.ibm.com>
	<20080406.232220.69225114.davem@davemloft.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

David Miller writes:

> Please let me know if you're going to require that I fix a bug that
> already exists in the LMB code just to get my NUMA node LMB allocation
> support patch in.

My thought was to put your patch in as-is with another patch to fix
the existing bug either immediately before it or immediately after
it.  I started reading through lmb.c again today but got distracted by
some other things.  It looks like lmb.c could use a bit of a coding
style cleanup, if nothing else.

> Please be straightforward and don't just drop the patch quietly in
> situations like this, let me know what you want to happen in order to
> add the change.

I haven't dropped it, it's just that I haven't got through all of the
patches for .26 yet.

Paul.
