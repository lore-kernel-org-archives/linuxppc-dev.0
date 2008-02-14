Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id C2652DDF18
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Feb 2008 10:09:37 +1100 (EST)
Date: Thu, 14 Feb 2008 17:12:00 -0600
From: Olof Johansson <olof@lixom.net>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH 2/8] pseries: phyp dump: reserve-release proof-of-concept
Message-ID: <20080214231200.GA15724@lixom.net>
References: <47B13D2E.1070001@austin.ibm.com> <47B145E9.9020907@austin.ibm.com>
	<20080214034621.GA6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080214034621.GA6887@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Feb 14, 2008 at 02:46:21PM +1100, Tony Breeds wrote:

> Hi Manish,
> 	Sorry for the minor nits but this should be:
> 
> ---
>  * Linas Vepstas, Manish Ahuja 2008
>  * Copyright 2008 IBM Corp.
> ---
> 
> You can optionally use the '??' symbol after word 'Copyright' but you
> shouldn't use '(c)' anymore.
> 
> Also in at least one place you've misspelt "Copyright"

If we're going to nitpick, then I'd like to point out that the whole
series needs to be run through checkpatch and at least the whitespace
issues should be taken care of.

I'm still not convinced that this is a useful feature compared to
hardening kdump, especially now that ehea can handle kexec/kdump (patch
posted the other day). But in the end it's up to Paul if he wants to
take it or not, not me.


-Olof
