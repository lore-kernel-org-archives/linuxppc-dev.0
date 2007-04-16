Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 9C774DDECB
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Apr 2007 16:47:17 +1000 (EST)
Date: Mon, 16 Apr 2007 02:05:19 -0500
To: jgarzik@pobox.com
Subject: Re: [PATCH] [0/4] pasemi_mac: fixes and enhancements
Message-ID: <20070416070519.GA20688@lixom.net>
References: <20070416061654.GB19783@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070416061654.GB19783@lixom.net>
From: olof@lixom.net (Olof Johansson)
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Apr 16, 2007 at 01:16:54AM -0500, Olof Johansson wrote:
> Hi,
> 
> The four following patches contain a number of fixes and improvements
> of the pasemi_mac driver:

I just realized that these have been based on top of some OF API changes
that are in paulus' for-2.6.22 tree, and won't build on something based
on current mainline.

I'll fix this up when I respin based on first round of comments in the
next day or so. It should mostly be a matter of doing rename of_$foo()
-> $foo().


-Olof
