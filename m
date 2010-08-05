Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 707ADB6EF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  6 Aug 2010 03:53:31 +1000 (EST)
Subject: Re: [PATCH v2 5/7] powerpc/85xx: Add MChk handler for SRIO port
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <0CE8B6BE3C4AD74AB97D9D29BD24E552011935BD@CORPEXCH1.na.ads.idt.com>
Date: Thu, 5 Aug 2010 12:53:03 -0500
Message-Id: <C9528078-D64C-4944-B960-0E985B3EE0BA@kernel.crashing.org>
References: <20100308191005.GE4324@amak.tundra.com>
	<AANLkTine3pc2Ai2Woj81Y9fS_KgGs1sIMb2NMR6G74ww@mail.gmail.com>
	<AANLkTinKbimKyLpvFD7KOvavshu_n8gRcp2BvEJj0XZQ@mail.gmail.com>
	<4381.1280815590@neuling.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E5520114309D@CORPEXCH1.na.ads.idt.com>
	<AANLkTinpwYnyc1oN1VbtBgUF6bk6E5q_Gq1Dj3WXV3wc@mail.gmail.com>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011430BC@CORPEXCH1.na.ads.idt.com>
	<26581.1280979260@neuling.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011935BD@CORPEXCH1.na.ads.idt.com>
To: "Bounine, Alexandre" <Alexandre.Bounine@IDT.COM>
Cc: Michael Neuling <mikey@neuling.org>, Li Yang-R58472 <r58472@freescale.com>,
	linux-kernel@vger.kernel.org,
	Alexandre Bounine <abounine@tundra.com>, thomas.moll@sysgo.com,
	linuxppc-dev@lists.ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 5, 2010, at 12:25 PM, Bounine, Alexandre wrote:

> Below is a copy of Leo's message with pointers to the patches.
>=20
> Alex.
>=20
>> Subject: [PATCH] RapidIO,powerpc/85xx: remove MCSR_MASK in fsl_rio
>>=20
>> Fixes compile problem caused by MCSR_MASK removal from book-E
> definitions.
>=20
> Hi Alex,
>=20
> Only with your patch, there will still be problem on SRIO platforms
> other than MPC85xx.
>=20
> I have posted a patch series to fix this together with several
> compatibility issues a month before.
>=20
> http://patchwork.ozlabs.org/patch/56135/
> http://patchwork.ozlabs.org/patch/56136/
> http://patchwork.ozlabs.org/patch/56138/
> http://patchwork.ozlabs.org/patch/56137/
>=20
>=20
> Can anyone pick the patch series quickly as currently there is a =
compile
> error when SRIO is enabled.
>=20
> - Leo

I'm looking at this now and wondering what we added the mcheck handler =
for in the first place and what its trying to accomplish.

- k
