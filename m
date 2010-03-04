Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id CB9DFB7C33
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Mar 2010 23:17:00 +1100 (EST)
To: hs@denx.de
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH 0/4] 8xx: Optimize TLB Miss code.
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <4B8F8BB4.6070201@denx.de>
References: <4B8E17A7.10509@denx.de>
	<OF5AEF2DED.4E6AA5A2-ONC12576DB.002FD2D9-C12576DB.00305B81@transmode.se>
	<4B8E3582.8060003@denx.de>
	<OF1C3DEF4A.B7A4D572-ONC12576DB.003876E8-C12576DB.003A7EEF@transmode.se>
	<4B8F8BB4.6070201@denx.de>
Date: Thu, 04 Mar 2010 13:16:56 +0100
Message-Id: <20100304121656.6758A28BBC@gemini.denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Heiko,

thanks for running the tests.

In message <4B8F8BB4.6070201@denx.de> you wrote:
> 
> here the results:
> 
> run	version
> 
> 1-4	2.6.33-rc6 without your patches
> 5-8	2.6.33-rc6 with all your patches
> 9-12	2.6.33-rc6 with patches 1,2 and 4 (without 8xx: Don't touch ACCESSED when no SWAP)
> 13-16	2.6.33-rc6 with all your patches and CONFIG_PIN_TLB=y

So CONFIG_PIN_TLB imroves the performance as expected, while the other
patches don;t show any measurable improvememt - or am I reading the
results incorrectly?


Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
And now remains  That we find out the cause of this effect, Or rather
say, the cause of this defect...           -- Hamlet, Act II, Scene 2
