Return-Path: <geoff@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:4830:2446:ff00:4687:fcff:fea6:5117])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id EB7092C01D9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 21:36:09 +1000 (EST)
Message-ID: <1368099347.3453.1.camel@clam>
Subject: Re: [PATCH 20/21] powerpc/ps3: remove inline marking of
 EXPORT_SYMBOL functions
From: Geoff Levand <geoff@infradead.org>
To: Denis Efremov <yefremov.denis@gmail.com>
Date: Thu, 09 May 2013 19:35:47 +0800
In-Reply-To: <1368095819-11011-9-git-send-email-yefremov.denis@gmail.com>
References: <1368086241-9357-1-git-send-email-yefremov.denis@gmail.com>
 <1368095819-11011-9-git-send-email-yefremov.denis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ldv-project@linuxtesting.org, trivial@kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-09 at 14:36 +0400, Denis Efremov wrote:
> EXPORT_SYMBOL and inline directives are contradictory to each other.
> The patch fixes this inconsistency.
> 
> Found by Linux Driver Verification project (linuxtesting.org).
> 
> Signed-off-by: Denis Efremov <yefremov.denis@gmail.com>
> ---
>  arch/powerpc/platforms/ps3/spu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Looks good, thanks.

Acked-by: Geoff Levand <geoff@infradead.org>
