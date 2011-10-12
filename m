Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 80778B6F76
 for <linuxppc-dev@ozlabs.org>; Wed, 12 Oct 2011 15:29:57 +1100 (EST)
Subject: Re: [PATCH 1/2] powerpc: respect mem= setting for early memory limit
 setup
Mime-Version: 1.0 (Apple Message framework v1244.3)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1316187599-27549-1-git-send-email-galak@kernel.crashing.org>
Date: Tue, 11 Oct 2011 23:29:54 -0500
Message-Id: <EBE7DCBA-A994-4753-8593-E2923D25FCD7@kernel.crashing.org>
References: <1316187599-27549-1-git-send-email-galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Sep 16, 2011, at 10:39 AM, Kumar Gala wrote:

> For those MMUs that have some form of bolt'd linear mapping (TLB)
> required its rare that one ever sets mem= smaller than the size of that
> mapping.
> 
> However, on Book-E 64 parts the initial linear mapping is quite large
> (1G) so its quite reasonable that mem= is set smaller than that.
> 
> We need to parse the command line for mem= limit and constrain the
> amount of memory we map initially by it if need be.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/kernel/prom.c |    5 ++++-
> 1 files changed, 4 insertions(+), 1 deletions(-)

applied

- k
