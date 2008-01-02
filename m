Return-Path: <olof@lixom.net>
Received: from mail.lixom.net (lixom.net [66.141.50.11])
	by ozlabs.org (Postfix) with ESMTP id A4311DDE05
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 07:21:54 +1100 (EST)
Date: Wed, 2 Jan 2008 14:30:18 -0600
From: Olof Johansson <olof@lixom.net>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH 3/5] [POWERPC] pasemi: Use machine_*_initcall() hooks
	in platform code
Message-ID: <20080102203018.GB17792@lixom.net>
References: <20080102191135.24178.99973.stgit@trillian.secretlab.ca>
	<20080102191441.24178.42988.stgit@trillian.secretlab.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080102191441.24178.42988.stgit@trillian.secretlab.ca>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 02, 2008 at 12:32:28PM -0700, Grant Likely wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  arch/powerpc/platforms/pasemi/idle.c  |    5 +----
>  arch/powerpc/platforms/pasemi/setup.c |   10 ++--------
>  2 files changed, 3 insertions(+), 12 deletions(-)

Applied to for-2.6.25.

Thanks,

-Olof
