Return-Path: <oss@buserror.net>
Received: from host.buserror.net (host.buserror.net [209.198.135.123])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wwGmV1sjszDr13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 25 Jun 2017 12:46:50 +1000 (AEST)
Date: Sat, 24 Jun 2017 21:46:38 -0500
From: Scott Wood <oss@buserror.net>
To: Karim Eshapa <karim.eshapa@gmail.com>
Cc: roy.pledge@nxp.com, linux-kernel@vger.kernel.org,
 claudiu.manoil@nxp.com, colin.king@canonical.com,
 linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
 Li Yang <leoyang.li@nxp.com>
Message-ID: <20170625024638.t6awgp7omzq5dcnk@home.buserror.net>
References: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1493963118-11064-1-git-send-email-karim.eshapa@gmail.com>
Subject: Re: [v3] drivers:soc:fsl:qbman:qman.c: Sleep instead of stuck
 hacking jiffies.
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 05, 2017 at 07:45:18AM +0200, Karim Eshapa wrote:
> Use msleep() instead of stucking with
> long delay will be more efficient.
> 
> Signed-off-by: Karim Eshapa <karim.eshapa@gmail.com>
> ---
>  drivers/soc/fsl/qbman/qman.c | 6 +-----
>  1 file changed, 1 insertion(+), 5 deletions(-)

Acked-by: Scott Wood <oss@buserror.net>

(though the subject line should be "soc/qman: ...")

Leo, are you going to send this patch (and other qman patches) via
arm-soc?

-Scott
