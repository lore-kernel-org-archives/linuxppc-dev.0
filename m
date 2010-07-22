Return-Path: <timur.tabi@gmail.com>
Received: from mail-gy0-f170.google.com (mail-gy0-f170.google.com
	[209.85.160.170]) by ozlabs.org (Postfix) with ESMTP id 6D67E1007D1
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 10:28:39 +1000 (EST)
Received: by gyh4 with SMTP id 4so186164gyh.15
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jul 2010 17:28:37 -0700 (PDT)
MIME-Version: 1.0
Sender: timur.tabi@gmail.com
In-Reply-To: <1279749902-13459-1-git-send-email-timur@freescale.com>
References: <1279749902-13459-1-git-send-email-timur@freescale.com>
From: Timur Tabi <timur@freescale.com>
Date: Wed, 21 Jul 2010 19:28:07 -0500
Message-ID: <AANLkTimqWvRIlCT6ba_za_sYXIMKrend0m5_ysuvXAG1@mail.gmail.com>
Subject: Re: [alsa-devel] [PATCH] powerpc: rename immap_86xx.h to fsl_guts.h,
	and add 85xx support
To: alsa-devel@alsa-project.org, linuxppc-dev@ozlabs.org, lrg@slimlogic.co.uk,
	broonie@opensource.wolfsonmicro.com, kumar.gala@freescale.com
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 21, 2010 at 5:05 PM, Timur Tabi <timur@freescale.com> wrote:
> The immap_86xx.h header file only defines one data structure: the "global
> utilities" register set found on Freescale PowerPC SOCs. =A0Rename this f=
ile
> to fsl_guts.h to reflect its true purpose, and extend it to cover the "GU=
TS"
> register set on 85xx chips.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>

Argh, I forgot to add the text to explain e500 vs. e600.

V2 coming.



--=20
Timur Tabi
Linux kernel developer at Freescale
