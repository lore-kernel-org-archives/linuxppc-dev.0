Return-Path: <daniel.thompson@linaro.org>
Received: from mail-wm0-x241.google.com (mail-wm0-x241.google.com
 [IPv6:2a00:1450:400c:c09::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zBRjQ2HlQzDqHs
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jan 2018 21:18:49 +1100 (AEDT)
Received: by mail-wm0-x241.google.com with SMTP id g75so1789251wme.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jan 2018 02:18:48 -0800 (PST)
Date: Wed, 3 Jan 2018 10:18:43 +0000
From: Daniel Thompson <daniel.thompson@linaro.org>
To: Mathieu Malaterre <malat@debian.org>
Cc: no To-header on input <;,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] backlight: Fix old-style function definition
Message-ID: <20180103101843.vo5vw5vdmzuuy6mv@oak.lan>
References: <20171226141241.19500-1-malat@debian.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <20171226141241.19500-1-malat@debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Dec 26, 2017 at 03:12:41PM +0100, Mathieu Malaterre wrote:
> Fix warning:
> 
> drivers/macintosh/via-pmu-backlight.c: In function ‘pmu_backlight_init’:
> drivers/macintosh/via-pmu-backlight.c:140:13: warning: old-style function definition [-Wold-style-definition]
>  void __init pmu_backlight_init()
>              ^~~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Mathieu Malaterre <malat@debian.org>

Acked-by: Daniel Thompson <daniel.thompson@linaro.org>

> ---
>  drivers/macintosh/via-pmu-backlight.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/macintosh/via-pmu-backlight.c b/drivers/macintosh/via-pmu-backlight.c
> index 89ed51571b62..50ada02ae75d 100644
> --- a/drivers/macintosh/via-pmu-backlight.c
> +++ b/drivers/macintosh/via-pmu-backlight.c
> @@ -137,7 +137,7 @@ void pmu_backlight_set_sleep(int sleep)
>  }
>  #endif /* CONFIG_PM */
>  
> -void __init pmu_backlight_init()
> +void __init pmu_backlight_init(void)
>  {
>  	struct backlight_properties props;
>  	struct backlight_device *bd;
> -- 
> 2.11.0
> 
