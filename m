Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2697EB6F01
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 11:45:33 +1000 (EST)
Date: Tue, 20 Jul 2010 18:45:48 -0700 (PDT)
Message-Id: <20100720.184548.250802682.davem@davemloft.net>
To: mikpe@it.uu.se
Subject: Re: [PATCH] math-emu: correct test for downshifting fraction in
	_FP_FROM_INT()
From: David Miller <davem@davemloft.net>
In-Reply-To: <19524.51858.992299.119315@pilspetsen.it.uu.se>
References: <19524.51858.992299.119315@pilspetsen.it.uu.se>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Mikael Pettersson <mikpe@it.uu.se>
Date: Mon, 19 Jul 2010 23:58:42 +0200

> The kernel's math-emu code contains a macro _FP_FROM_INT() which is
> used to convert an integer to a raw normalized floating-point value.
> It does this basically in three steps:
 ...
> The fix is simple: the exponent comparison used to determine if the
> fraction should be downshifted must be "<=" not "<".
> 
> I'm sending a kernel module to test this as a reply to this message.
> There are also SPARC user-space test cases in the GCC bug entry.
> 
> Signed-off-by: Mikael Pettersson <mikpe@it.uu.se>

Applied and I'll make sure this gets into -stable too.

Thanks!
