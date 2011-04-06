Return-Path: <justinmattock@gmail.com>
Received: from mail-pv0-f179.google.com (mail-pv0-f179.google.com
	[74.125.83.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 9F7E51007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  7 Apr 2011 02:09:17 +1000 (EST)
Received: by pvf33 with SMTP id 33so655769pvf.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 06 Apr 2011 09:09:14 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <20110406110335.0f2d5f4c@schlenkerla.am.freescale.net>
References: <1302022702-24541-1-git-send-email-justinmattock@gmail.com>
	<1302022702-24541-2-git-send-email-justinmattock@gmail.com>
	<20110405131504.1d182da4@schlenkerla.am.freescale.net>
	<BANLkTi=5A1P-WAFvCyjbT7RVva9K9d=gQQ@mail.gmail.com>
	<20110406110335.0f2d5f4c@schlenkerla.am.freescale.net>
Date: Wed, 6 Apr 2011 09:09:14 -0700
Message-ID: <BANLkTi=CRxJqYdtD-kjA3buuWqYiSJEzxQ@mail.gmail.com>
Subject: Re: [RFC 2/5]arch:powerpc:sysdev:Makefile Remove unused config in the
	Makefile.
From: Justin Mattock <justinmattock@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, trivial@kernel.org,
	linux-kernel@vger.kernel.org, Harninder Rai <harninder.rai@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Apr 6, 2011 at 9:03 AM, Scott Wood <scottwood@freescale.com> wrote:
> On Wed, 6 Apr 2011 08:07:58 -0700
> Justin Mattock <justinmattock@gmail.com> wrote:
>
>> ahh.. so the: =A0fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o is still in use
>> even though FSL_85XX_CACHE_SRAM is not really used, but really is used!!
>>
>> but might be wrong with this.
>
> More like there are plans to use it, or possibly out-of-tree users. =A0We
> should prod people a bit to submit the driver patches that use this befor=
e
> we just yank it out.
>
> -Scott
>
>

well if this is going to be used for something down the line, then
best leave it in..

--=20
Justin P. Mattock
