Return-Path: <dja@axtens.net>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zVw1V0w3TzF0R1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jan 2018 16:29:48 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 17so6311531pfw.11
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jan 2018 21:29:48 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Larry Finger <Larry.Finger@lwfinger.net>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: [PATCH] macintosh: Add module license to ans-lcd
In-Reply-To: <20180129193308.25373-1-Larry.Finger@lwfinger.net>
References: <20180129193308.25373-1-Larry.Finger@lwfinger.net>
Date: Tue, 30 Jan 2018 16:29:41 +1100
Message-ID: <878tcfsym2.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

That matches the SPDX identifier from the top of the file, so:

Reviewed-by: Daniel Axtens <dja@axtens.net>

Regards,
Daniel

Larry Finger <Larry.Finger@lwfinger.net> writes:

> In kernel 4.15, the modprobe step on my PowerBook G5 started complaining that
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
