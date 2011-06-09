Return-Path: <dbaryshkov@gmail.com>
Received: from mail-vw0-f51.google.com (mail-vw0-f51.google.com
	[209.85.212.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id EC600B6FE1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 10 Jun 2011 01:01:14 +1000 (EST)
Received: by vws20 with SMTP id 20so1388442vws.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 09 Jun 2011 08:01:10 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <1306941318-5771-1-git-send-email-dbaryshkov@gmail.com>
References: <1306941318-5771-1-git-send-email-dbaryshkov@gmail.com>
Date: Thu, 9 Jun 2011 19:01:10 +0400
Message-ID: <BANLkTin=bz=+_Tmhm7++PWY3WHWDFpumNg@mail.gmail.com>
Subject: Re: [PATCH] ppc/85xx: specify interrupt for pq3-localbus devices
From: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
To: linuxppc-dev@lists.ozlabs.org,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sorry, if I'm being too noisy, what about this patch?

On 6/1/11, Dmitry Eremin-Solenikov <dbaryshkov@gmail.com> wrote:
> fsl-lbc driver requires an interrupt to bind to localbus device.
> Populate 85xx boards' dts trees with lbc interrupt info.
>
> Signed-off-by: Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>
> ---
>  arch/powerpc/boot/dts/mpc8568mds.dts       |    2 ++
>  arch/powerpc/boot/dts/socrates.dts         |    2 ++
>  arch/powerpc/boot/dts/tqm8540.dts          |    2 ++
>  arch/powerpc/boot/dts/tqm8548-bigflash.dts |    2 ++
>  arch/powerpc/boot/dts/tqm8548.dts          |    2 ++
>  arch/powerpc/boot/dts/tqm8560.dts          |    2 ++
>  arch/powerpc/boot/dts/xpedite5200.dts      |    2 ++
>  arch/powerpc/boot/dts/xpedite5200_xmon.dts |    2 ++
>  8 files changed, 16 insertions(+), 0 deletions(-)


-- 
With best wishes
Dmitry
