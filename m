Return-Path: <glikely@secretlab.ca>
Received: from wa-out-1112.google.com (wa-out-1112.google.com [209.85.146.178])
	by ozlabs.org (Postfix) with ESMTP id 5D2F5DDDE6
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Aug 2007 23:53:31 +1000 (EST)
Received: by wa-out-1112.google.com with SMTP id m28so217141wag
	for <linuxppc-dev@ozlabs.org>; Wed, 01 Aug 2007 06:53:29 -0700 (PDT)
Message-ID: <fa686aa40708010653v7e1fb909gb03eb1d4754359bf@mail.gmail.com>
Date: Wed, 1 Aug 2007 07:53:28 -0600
From: "Grant Likely" <grant.likely@secretlab.ca>
Sender: glikely@secretlab.ca
To: "Adrian Bunk" <bunk@stusta.de>
Subject: Re: [2.6 patch] ppc .gitignore update
In-Reply-To: <20070801133056.GP3972@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <20070801133056.GP3972@stusta.de>
Cc: Rutger Nijlunsing <rutger@nospam.com>, Paul Mackerras <paulus@samba.org>,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 8/1/07, Adrian Bunk <bunk@stusta.de> wrote:
> arch/ppc/.gitignore shouldn't exclude arch/ppc/boot/include
>
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
>
> ---
> --- /dev/null   2006-09-19 00:45:31.000000000 +0200
> +++ linux-2.6.23-rc1-mm2/arch/ppc/boot/.gitignore       2007-08-01 15:18:33.000000000 +0200
> @@ -0,0 +1 @@
> +!include

I don't think this is the best way to go about it; rather,
arch/ppc/.gitignore should be made more specific like so:

diff --git a/arch/ppc/.gitignore b/arch/ppc/.gitignore
index a1a869c..1e79a0a 100644
--- a/arch/ppc/.gitignore
+++ b/arch/ppc/.gitignore
@@ -1 +1 @@
-include
+/include

>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>


-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
grant.likely@secretlab.ca
(403) 399-0195
