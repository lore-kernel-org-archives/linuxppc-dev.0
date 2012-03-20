Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id D443BB6EF1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Mar 2012 08:09:24 +1100 (EST)
Subject: Re: [PATCH] powerpc/crypto: caam - add backward compatible string
 sec4.0
Mime-Version: 1.0 (Apple Message framework v1257)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1332137973-32660-1-git-send-email-Shengzhou.Liu@freescale.com>
Date: Tue, 20 Mar 2012 16:08:55 -0500
Message-Id: <F38A71C1-6781-4E43-BB20-4C674A41B5AB@kernel.crashing.org>
References: <1332137973-32660-1-git-send-email-Shengzhou.Liu@freescale.com>
To: Shengzhou Liu <Shengzhou.Liu@freescale.com>
Cc: "linuxppc-dev@lists.ozlabs.org list" <linuxppc-dev@lists.ozlabs.org>,
 stable <stable@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 19, 2012, at 1:19 AM, Shengzhou Liu wrote:

> In some device trees of previous version, there were string "fsl,sec4.0".
> To be backward compatible with device trees, we have CAAM driver first
> check "fsl,sec-v4.0", if it fails, then check for "fsl,sec4.0".
> 
> Signed-off-by: Shengzhou Liu <Shengzhou.Liu@freescale.com>
> ---
> drivers/crypto/caam/caamalg.c |   14 ++++++++++----
> drivers/crypto/caam/ctrl.c    |   16 ++++++++++++++++
> 2 files changed, 26 insertions(+), 4 deletions(-)

Should be sent to the linux crypto list & maintainer.

- k
