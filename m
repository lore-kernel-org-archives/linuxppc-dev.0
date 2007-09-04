Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 21717DDE2F
	for <linuxppc-dev@ozlabs.org>; Wed,  5 Sep 2007 10:32:29 +1000 (EST)
Date: Tue, 4 Sep 2007 18:39:18 -0500
From: Olof Johansson <olof@lixom.net>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [POWERPC] flags as passed to spin_*_irqsave() should be
	unsigned long.
Message-ID: <20070904233918.GA20412@lixom.net>
References: <20070905002314.GT10345@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20070905002314.GT10345@bakeyournoodle.com>
Cc: LinuxPPC-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Sep 05, 2007 at 10:23:14AM +1000, Tony Breeds wrote:
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> 
> ---
> Found trying to build a -rt kernel, which has a BUILD_BUG_ON(), in this
> caswe.

Thanks, applied. I'll batch it up with the next set of updates to jgarzik.


-Olof
