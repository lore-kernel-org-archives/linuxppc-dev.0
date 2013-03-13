Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id AD6452C008D
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Mar 2013 06:23:07 +1100 (EST)
Subject: Re: [PATCH][v4] PPC: add paravirt idle loop for 64-bit book E
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1360351376-5323-1-git-send-email-stuart.yoder@freescale.com>
Date: Wed, 13 Mar 2013 14:22:59 -0500
Message-Id: <C3FFC46C-D55C-47E7-BC94-64732BB6376B@kernel.crashing.org>
References: <1360351376-5323-1-git-send-email-stuart.yoder@freescale.com>
To: Stuart Yoder <stuart.yoder@freescale.com>
Cc: kvm-ppc@vger.kernel.org, agraf@suse.de, kvm@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 8, 2013, at 1:22 PM, Stuart Yoder wrote:

> From: Stuart Yoder <stuart.yoder@freescale.com>
> 
> Signed-off-by: Stuart Yoder <stuart.yoder@freescale.com>
> ---
> 
> -removed KVM prefix to patch subject, patch is not KVM specific
> 
> arch/powerpc/kernel/epapr_hcalls.S |    2 ++
> arch/powerpc/kernel/idle_book3e.S  |   32 ++++++++++++++++++++++++++++++--
> 2 files changed, 32 insertions(+), 2 deletions(-)

applied to next

- k
