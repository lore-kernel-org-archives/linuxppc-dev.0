Return-Path: <vapier.adi@gmail.com>
Received: from mail-fx0-f42.google.com (mail-fx0-f42.google.com
	[209.85.161.42]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id AD7E8B7019
	for <linuxppc-dev@ozlabs.org>; Thu, 23 Jun 2011 00:38:05 +1000 (EST)
Received: by fxm1 with SMTP id 1so794269fxm.15
	for <linuxppc-dev@ozlabs.org>; Wed, 22 Jun 2011 07:38:00 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1308744176-24491-1-git-send-email-galak@kernel.crashing.org>
References: <1308744176-24491-1-git-send-email-galak@kernel.crashing.org>
From: Mike Frysinger <vapier.adi@gmail.com>
Date: Wed, 22 Jun 2011 10:37:40 -0400
Message-ID: <BANLkTin+_G7HZgBTy-=EWZBR0hBAPyKv3w@mail.gmail.com>
Subject: Re: [PATCH 1/3] driver core: Add ability for arch code to setup
	pdev_archdata
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 22, 2011 at 08:02, Kumar Gala wrote:
> --- /dev/null
> +++ b/include/asm-generic/platform_device.h
> @@ -0,0 +1,11 @@

missing header blob with explanation/copyright/license

> +/*
> + * an architecture can override to define arch_setup_pdev_archdata
> + */
> +#ifndef arch_setup_pdev_archdata
> +static inline void arch_setup_pdev_archdata(struct platform_device *pdev) { }
> +#endif

missing explanation of what the func actually does, and this header
lacks a forward struct decl for platform_device
-mike
