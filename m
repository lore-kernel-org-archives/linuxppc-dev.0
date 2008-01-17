Return-Path: <glikely@secretlab.ca>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by ozlabs.org (Postfix) with ESMTP id 4464CDDDFB
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Jan 2008 04:21:36 +1100 (EST)
Received: by an-out-0708.google.com with SMTP id c37so163396anc.78
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Jan 2008 09:21:34 -0800 (PST)
Message-ID: <fa686aa40801170921r661db0fcue5b91cd53683a0b5@mail.gmail.com>
Date: Thu, 17 Jan 2008 10:21:34 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "John Rigby" <jrigby@freescale.com>
Subject: Re: [Add mpc5121 support PATCH v2 3/8] Basic Freescale MPC512x support
In-Reply-To: <1200519447-25555-3-git-send-email-jrigby@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1200519447-25555-1-git-send-email-jrigby@freescale.com>
	<1200519447-25555-2-git-send-email-jrigby@freescale.com>
	<1200519447-25555-3-git-send-email-jrigby@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 1/16/08, John Rigby <jrigby@freescale.com> wrote:
> 512x is very similar to 83xx and most
> of this is patterned after code from 83xx.
>
> New platform:
>     changed:
>         arch/powerpc/Kconfig
>         arch/powerpc/platforms/Kconfig
>         arch/powerpc/platforms/Kconfig.cputype
>         arch/powerpc/platforms/Makefile
>     new:
>         arch/powerpc/platforms/512x/*
>         include/asm-powerpc/mpc512x.h
>
> Signed-off-by: John Rigby <jrigby@freescale.com>

After Stephen's comment is addressed:

Acked-by: Grant Likely <grant.likely@secretlab.ca>
-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
