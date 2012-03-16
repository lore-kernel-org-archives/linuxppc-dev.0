Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id C08EDB7047
 for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2012 02:24:35 +1100 (EST)
Received: from [127.0.0.1] (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id q2GFORYP003819
 for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2012 10:24:31 -0500
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Apple Message framework v1257)
Subject: Re: [PATCH 2/2] powerpc: Add initial e6500 cpu support
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1326915580-19652-2-git-send-email-galak@kernel.crashing.org>
Date: Fri, 16 Mar 2012 10:15:43 -0500
Message-Id: <6A92B1AD-4FA5-4002-8BF6-B05A4A1AC188@kernel.crashing.org>
References: <1326915580-19652-1-git-send-email-galak@kernel.crashing.org>
 <1326915580-19652-2-git-send-email-galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jan 18, 2012, at 1:39 PM, Kumar Gala wrote:

> Add basic support for e6500 core in its single threaded mode.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/cputable.h |   12 ++++++++----
> arch/powerpc/kernel/cputable.c      |   18 ++++++++++++++++++
> 2 files changed, 26 insertions(+), 4 deletions(-)

applied

- k
