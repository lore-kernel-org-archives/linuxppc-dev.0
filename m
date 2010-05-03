Return-Path: <brian@aljex.com>
Received: from smtp141.iad.emailsrvr.com (smtp141.iad.emailsrvr.com
	[207.97.245.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 91953B7D57
	for <linuxppc-dev@ozlabs.org>; Mon,  3 May 2010 19:01:37 +1000 (EST)
Message-ID: <4BDE8DCB.4000404@aljex.com>
Date: Mon, 03 May 2010 04:48:11 -0400
From: "Brian K. White" <brian@aljex.com>
MIME-Version: 1.0
To: David Miller <davem@davemloft.net>
Subject: Re: [PATCH v21 001/100] eclone (1/11): Factor out code to allocate
	pidmap page
References: <1272723382-19470-1-git-send-email-orenl@cs.columbia.edu>	<1272723382-19470-2-git-send-email-orenl@cs.columbia.edu>
	<20100501.151022.190375136.davem@davemloft.net>
In-Reply-To: <20100501.151022.190375136.davem@davemloft.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-s390@vger.kernel.org, orenl@cs.columbia.edu,
	containers@lists.linux-foundation.org, x86@kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	linux-api@vger.kernel.org, akpm@linux-foundation.org,
	sukadev@linux.vnet.ibm.com, xemul@openvz.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Miller wrote:
> NO WAY, there is no way in the world you should post 100 patches
> at a time to any mailing list, especially those at vger.kernel.org
> that have thousands upon thousands of subscribers.
> 
> Post only small, well contained, sets of patches at a time.  At most
> 10 or so in one go.
> 
> Do you realize how much mail traffic you generate by posting so many
> patches at one time, and how unlikely it is for anyone to actually
> sift through and review your patches after you've spammed them by
> posting so many at one time?
> 
> A second infraction and I will have no choice but to block you at the
> SMTP level at vger.kernel.org so please do not do it again.

Some people, you give them gold and they just complain it's heavy.

-- 
bkw
