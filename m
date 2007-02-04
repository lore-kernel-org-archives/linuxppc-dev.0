Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id 38A32DDE47
	for <linuxppc-dev@ozlabs.org>; Mon,  5 Feb 2007 09:17:36 +1100 (EST)
Date: Sun, 4 Feb 2007 16:25:02 -0600
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [4/9] pasemi: Idle loops
Message-ID: <20070204222502.GB2862@lixom.net>
References: <20070202045448.145851000@lixom.net>
	<20070202045448.145851000@lixom.net>>
	<20070202045508.379230000@lixom.net>>
	<200702030927.49659.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200702030927.49659.arnd@arndb.de>
From: olof@lixom.net (Olof Johansson)
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, Feb 03, 2007 at 09:27:49AM +0100, Arnd Bergmann wrote:

> Can you do this using a power_save() callback instead of
> an idle() callback? We've already moved over practically
> all platforms to power_save(), it would be good to
> kill off the ppc_md.idle() function as soon as it's
> unneeded.

Good point. I've been carrying this patch since before then, that's why
I wasn't already using it. I'll revise and repost.


-Olof
