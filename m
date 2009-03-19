Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 02B77DE3CD
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 19:57:32 +1100 (EST)
Message-Id: <ADF50FBD-4E84-4520-A1DB-3613166E45B1@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Martyn Welch <martyn.welch@gefanuc.com>
In-Reply-To: <20090313113258.6583.64155.stgit@ubuntu8041.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] powerpc/86xx: Run sbc310 USB fixup code only on the
	appropriate platform.
Date: Thu, 19 Mar 2009 03:57:22 -0500
References: <20090313113258.6583.64155.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 13, 2009, at 6:35 AM, Martyn Welch wrote:

> Patch to limit NEC fixup to SBC310, following similar patch to  
> SBC610 by Tony Breeds: 368a12117dd8abf6eaefa37c21ac313b517128b9
>
> Signed-off-by: Martyn Welch <martyn.welch@gefanuc.com>
> ---
>
> Hi Kumar,
>
> The sbc310 patches have been added to your next tree. This patch is
> needed to stop the same problem occuring as occured with the sbc610.
>
> arch/powerpc/platforms/86xx/gef_sbc310.c |    4 ++++
> 1 files changed, 4 insertions(+), 0 deletions(-)

applied

- k
