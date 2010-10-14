Return-Path: <timur.tabi@gmail.com>
Received: from mail-iw0-f170.google.com (mail-iw0-f170.google.com
	[209.85.214.170]) by ozlabs.org (Postfix) with ESMTP id AC6CBB70E4
	for <linuxppc-dev@ozlabs.org>; Fri, 15 Oct 2010 00:51:32 +1100 (EST)
Received: by iwn37 with SMTP id 37so7445833iwn.15
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 06:51:31 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1287062710-8621-1-git-send-email-galak@kernel.crashing.org>
References: <1287062710-8621-1-git-send-email-galak@kernel.crashing.org>
From: Timur Tabi <timur@freescale.com>
Date: Thu, 14 Oct 2010 08:51:01 -0500
Message-ID: <AANLkTinJq78ZQbW_r0mJqA884-Mt+a_m6pJSLn-PAGuT@mail.gmail.com>
Subject: Re: [PATCH] powerpc/fsl-booke: Add e500mc smp defconfig
To: Kumar Gala <galak@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 14, 2010 at 8:25 AM, Kumar Gala <galak@kernel.crashing.org> wrote:

> +CONFIG_MATH_EMULATION=y

Don't these chips have hardware FP?

> +CONFIG_E1000=y
> +CONFIG_E1000E=y

Are you sure you want these on by default?  We may use the E1000 cards
in-house, but I don't know if our customers do.

> +CONFIG_MSDOS_FS=m
> +CONFIG_VFAT_FS=y
> +CONFIG_NTFS_FS=y

These should probably be off as well.

-- 
Timur Tabi
Linux kernel developer at Freescale
