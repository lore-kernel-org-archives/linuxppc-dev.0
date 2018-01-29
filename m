Return-Path: <paubert@iram.es>
Received: from cica-lavadora-l1mail3.puc.rediris.es
 (ci-l1mail3-out03a.puc.rediris.es [IPv6:2001:720:418:ca02::29])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVlPH4832zDqgQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 10:01:21 +1100 (AEDT)
Date: Mon, 29 Jan 2018 23:49:39 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] macintosh: Add module license to ans-lcd
Message-ID: <20180129224939.eyhko7bnr4ooxr4g@lt-gp.iram.es>
References: <20180129193308.25373-1-Larry.Finger@lwfinger.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180129193308.25373-1-Larry.Finger@lwfinger.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jan 29, 2018 at 01:33:08PM -0600, Larry Finger wrote:
> In kernel 4.15, the modprobe step on my PowerBook G5 started complaining that
    
PowerBook G5? Really, could you send a pic! :-)

> there was no module license for ans-lcd.
> 
> Signed-off-by: Larry Finger <Larry.Finger@lwfinger.net>
> ---
>  drivers/macintosh/ans-lcd.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/macintosh/ans-lcd.c b/drivers/macintosh/ans-lcd.c
> index 1de81d922d8a..c8e078b911c7 100644
> --- a/drivers/macintosh/ans-lcd.c
> +++ b/drivers/macintosh/ans-lcd.c
> @@ -201,3 +201,4 @@ anslcd_exit(void)
>  
>  module_init(anslcd_init);
>  module_exit(anslcd_exit);
> +MODULE_LICENSE("GPL v2");
> -- 
> 2.16.1
> 
