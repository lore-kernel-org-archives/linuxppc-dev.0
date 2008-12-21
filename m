Return-Path: <timur.tabi@gmail.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id A4DC7DDDE0
	for <linuxppc-dev@ozlabs.org>; Sun, 21 Dec 2008 14:27:33 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so534549yxg.39
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Dec 2008 19:27:31 -0800 (PST)
Message-ID: <ed82fe3e0812201927j2cf2786ag320e9ebd3b7c7954@mail.gmail.com>
Date: Sat, 20 Dec 2008 21:27:31 -0600
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Becky Bruce" <beckyb@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Update 8641hpcn dts file to match latest u-boot
In-Reply-To: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Dec 19, 2008 at 4:05 PM, Becky Bruce <beckyb@kernel.crashing.org> wrote:
> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
> @@ -26,7 +26,7 @@
>                serial1 = &serial1;
>                pci0 = &pci0;
>                pci1 = &pci1;
> -               rapidio0 = &rapidio0;
> +               /* rapidio0 = &rapidio0; */

If you're going to leave commented-out code in the DTS, please add a
comment here to explain why the code is commented-out and not just
deleted.

-- 
Timur Tabi
Linux kernel developer at Freescale
