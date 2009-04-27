Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net (unknown [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id C5836DDED9
	for <linuxppc-dev@ozlabs.org>; Mon, 27 Apr 2009 16:06:57 +1000 (EST)
Date: Sun, 26 Apr 2009 23:06:48 -0700 (PDT)
Message-Id: <20090426.230648.254087966.davem@davemloft.net>
To: rbrito@ime.usp.br
Subject: Re: [2.6.30-rc3] powerpc: compilation error of mace module
From: David Miller <davem@davemloft.net>
In-Reply-To: <20090426155708.GA23159@ime.usp.br>
References: <20090426155708.GA23159@ime.usp.br>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=iso-8859-1
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Rog=E9rio Brito <rbrito@ime.usp.br>
Date: Sun, 26 Apr 2009 12:57:09 -0300

> I am attempting to compile a new kernel for my OldWorld ppc box and I=
'm
> having some problems. The first one that appears to happen is the fol=
lowing:

Turn on CONFIG_COMPAT_NET_DEV_OPS in your kernel config.

There was no reason for you to turn that off, and you had
to have done it explicitly I think :-)

Or, if you're bored, feel free to convert the mace driver over
to netdev_ops :-)
