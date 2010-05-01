Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id 2C6EEB7D5B
	for <linuxppc-dev@ozlabs.org>; Sun,  2 May 2010 08:10:18 +1000 (EST)
Date: Sat, 01 May 2010 15:10:22 -0700 (PDT)
Message-Id: <20100501.151022.190375136.davem@davemloft.net>
To: orenl@cs.columbia.edu
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
From: David Miller <davem@davemloft.net>
In-Reply-To: <1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>
	<1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-s390@vger.kernel.org, linux-api@vger.kernel.org,
	containers@lists.linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	matthltc@us.ibm.com, serue@us.ibm.com, akpm@linux-foundation.org,
	sukadev@linux.vnet.ibm.com, xemul@openvz.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


NO WAY, there is no way in the world you should post 100 patches
at a time to any mailing list, especially those at vger.kernel.org
that have thousands upon thousands of subscribers.

Post only small, well contained, sets of patches at a time.  At most
10 or so in one go.

Do you realize how much mail traffic you generate by posting so many
patches at one time, and how unlikely it is for anyone to actually
sift through and review your patches after you've spammed them by
posting so many at one time?

A second infraction and I will have no choice but to block you at the
SMTP level at vger.kernel.org so please do not do it again.

Thanks.
