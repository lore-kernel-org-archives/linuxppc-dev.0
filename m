Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 6D9F6DDE39
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 15:17:58 +1100 (EST)
Date: Tue, 6 Feb 2007 22:25:43 -0600
To: Paul Mackerras <paulus@samba.org>
Subject: Re: patches in powerpc.git
Message-ID: <20070207042543.GA27993@lixom.net>
References: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17865.20353.116215.380614@cargo.ozlabs.ibm.com>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 07, 2007 at 03:03:13PM +1100, Paul Mackerras wrote:
> The following is the list of commits that I have in the powerpc.git
> tree, and which I plan to ask Linus to pull tomorrow.  If anyone
> thinks any of these should *not* go in, let me know quickly.
[...]
>       [POWERPC] pasemi: Configure DMA controller interrupts

I agreed with Ben that this one should go in the driver instead, but I
didn't repost the series without it.

It's no big deal that it's in there right now, I'll back it out in the
same patch that adds it to the driver.


Thanks,

-Olof
