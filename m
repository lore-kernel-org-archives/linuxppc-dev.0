Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net
	[IPv6:2001:a60:0:32:0:1:25:1])
	by ozlabs.org (Postfix) with ESMTP id B988E1007D3
	for <linuxppc-dev@ozlabs.org>; Fri, 23 Sep 2011 09:01:53 +1000 (EST)
Date: Fri, 23 Sep 2011 01:01:25 +0200
From: Anatolij Gustschin <agust@denx.de>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc/5200: enable audio in the defconfig
Message-ID: <20110923010125.1bcf3d9a@wker>
In-Reply-To: <1314916282-13863-1-git-send-email-timur@freescale.com>
References: <1314916282-13863-1-git-send-email-timur@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 1 Sep 2011 17:31:22 -0500
Timur Tabi <timur@freescale.com> wrote:

> Audio support for the MPC5200 exists, so enable it by default.
> 
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> 
> There was a bug in the audio drivers related to the of_platform
> changes that was never discovered because these drivers were
> never compiled by default.  This patch should make sure that
> never happens again.
> 
>  arch/powerpc/configs/mpc5200_defconfig |   12 ++++++++++++
>  1 files changed, 12 insertions(+), 0 deletions(-)

applied to next, thanks.

Anatolij
