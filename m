Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 91ADEB7B6B
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 05:50:33 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.14.3/az33egw02) with ESMTP id
	n98Imhba000577
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 11:48:45 -0700 (MST)
Received: from b07421-ec1.am.freescale.net (b07421-ec1.am.freescale.net
	[10.82.121.43])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id n98IpMIG003584
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Oct 2009 13:51:22 -0500 (CDT)
Date: Thu, 8 Oct 2009 13:48:42 -0500
From: Scott Wood <scottwood@freescale.com>
To: nanda <nanda74pg@rediffmail.com>
Subject: Re: Crash in the kernel panic linux mpc 832x
Message-ID: <20091008184842.GA28235@b07421-ec1.am.freescale.net>
References: <20090916150233.33919.qmail@f5mail-237-241.rediffmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090916150233.33919.qmail@f5mail-237-241.rediffmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 16, 2009 at 03:02:33PM -0000, nanda wrote:
> Hi,
>   Iam getting the below crash on new board tested on MPC832x using
>   linux-2.6.24, please let me what could be the problem on the same.
>   Does it infer any information on the exception?

Please try running the latest kernel.

> # Oops: Exception in kernel mode, sig: 4 [#1]
> PREEMPT MPC832x RDB
> Modules linked in:

I think you left off some relevant ines before this -- was there anything
like "kernel BUG in line ..."?  Do you have verbose BUG reporting
enabled?

-Scott
