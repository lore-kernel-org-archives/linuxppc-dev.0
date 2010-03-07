Return-Path: <joakim.tjernlund@transmode.se>
Received: from gw1.transmode.se (gw1.transmode.se [213.115.205.20])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EAFE3B7CBD
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Mar 2010 03:06:15 +1100 (EST)
In-Reply-To: <4B8FE00F.4030405@denx.de>
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
	<4B8F8BB4.6070201@denx.de>
	<20100304121656.6758A28BBC@gemini.denx.de>
	<OF22F52BE0.FB3F104E-ONC12576DC.00469DB5-C12576DC.004808C4@transmode.se>
	<4B8FE00F.4030405@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
To: hs@denx.de
Message-ID: <OF27863334.BCE2FAFA-ONC12576DF.0057DB90-C12576DF.00583BDC@transmode.se>
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Sun, 7 Mar 2010 17:03:44 +0100
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-15
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Heiko Schocher <hs@denx.de> wrote on 2010/03/04 17:30:07:

> From: Heiko Schocher <hs@denx.de>
> To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
> Cc: Wolfgang Denk <wd@denx.de>, Klaus-J=FCrgen <heydeck@kieback-peter=
.de>,
> linuxppc-dev@ozlabs.org, Scott Wood <scottwood@freescale.com>
> Date: 2010/03/04 17:30
> Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
>
> Hello Joakim,
>
> Joakim Tjernlund wrote:
> > Wolfgang Denk <wd@denx.de> wrote on 2010/03/04 13:16:56:
> >> From: Wolfgang Denk <wd@denx.de>
> >> To: hs@denx.de
> >> Cc: Joakim Tjernlund <joakim.tjernlund@transmode.se>, Klaus-J=FCrg=
en
> >> <heydeck@kieback-peter.de>, linuxppc-dev@ozlabs.org, Scott Wood
> >> <scottwood@freescale.com>
> >> Date: 2010/03/04 13:17
> >> Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
> >>
> >> Dear Heiko,
> >>
> >> thanks for running the tests.
> >>
> >> In message <4B8F8BB4.6070201@denx.de> you wrote:
> >>> here the results:
> >>>
> >>> run   version
> >>>
> >>> 1-4   2.6.33-rc6 without your patches
> >>> 5-8   2.6.33-rc6 with all your patches
> >>> 9-12   2.6.33-rc6 with patches 1,2 and 4 (without 8xx: Don't touc=
h ACCESSED
> >> when no SWAP)
> >>> 13-16   2.6.33-rc6 with all your patches and CONFIG_PIN_TLB=3Dy
> >> So CONFIG_PIN_TLB imroves the performance as expected, while the o=
ther
> >> patches don;t show any measurable improvememt - or am I reading th=
e
> >> results incorrectly?

BTW, I have impl. all of the newer 2.6 TLB/MMU fixes(including the dcbX=
 fixup) for 2.4 as well.
If there is any interest I can polish them and submit for 2.4? I do nee=
d an external tester
for that though.

 Jocke=
