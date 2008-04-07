Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C05F2DDD04
	for <linuxppc-dev@ozlabs.org>; Mon,  7 Apr 2008 16:22:21 +1000 (EST)
Date: Sun, 06 Apr 2008 23:22:20 -0700 (PDT)
Message-Id: <20080406.232220.69225114.davem@davemloft.net>
To: paulus@samba.org
Subject: Re: Patches added to powerpc.git powerpc-next and master branches
From: David Miller <davem@davemloft.net>
In-Reply-To: <18425.46732.651483.504040@cargo.ozlabs.ibm.com>
References: <18425.46732.651483.504040@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>
Date: Mon, 7 Apr 2008 15:52:12 +1000

> The following patches have been added to the master and powerpc-next
> branches of the powerpc.git repository.  There is a bunch that I
> pulled from Josh Boyer's tree plus others that I have committed.

Please let me know if you're going to require that I fix a bug that
already exists in the LMB code just to get my NUMA node LMB allocation
support patch in.

Please be straightforward and don't just drop the patch quietly in
situations like this, let me know what you want to happen in order to
add the change.
