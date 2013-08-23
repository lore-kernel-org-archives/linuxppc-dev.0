Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 909AA2C0077
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Aug 2013 07:49:16 +1000 (EST)
Date: Fri, 23 Aug 2013 23:49:12 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Gerhard Sittig <gsi@denx.de>
Subject: Re: [PATCH v4 12/31] powerpc: mpc512x: array decl for MCLK
 registers in CCM
Message-ID: <20130823234912.7d60032d@crub>
In-Reply-To: <1375821851-31609-13-git-send-email-gsi@denx.de>
References: <1374495298-22019-1-git-send-email-gsi@denx.de>
 <1375821851-31609-1-git-send-email-gsi@denx.de>
 <1375821851-31609-13-git-send-email-gsi@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue,  6 Aug 2013 22:43:52 +0200
Gerhard Sittig <gsi@denx.de> wrote:

> reword the clock control module's registers declaration such that the
> MCLK related registers form an array and get indexed by PSC controller
> or CAN controller component number
> 
> this change is in preparation to COMMON_CLK support for the MPC512x
> platform, the changed declaration remains neutral to existing code since
> the PSC and MSCAN CCR fields declared here aren't referenced anywhere
> 
> Signed-off-by: Gerhard Sittig <gsi@denx.de>
> ---
>  arch/powerpc/include/asm/mpc5121.h |   18 ++----------------
>  1 file changed, 2 insertions(+), 16 deletions(-)

Applied, thanks!

Anatolij
