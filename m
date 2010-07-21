Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 3DB91B70BD
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jul 2010 08:47:06 +1000 (EST)
To: Bradley Hughes <bhughes@silicontkx.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH v2 0/2] Adding DTS for the STx GP3-SSA MPC8555 board
MIME-Version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <AANLkTimMb_PshxAIDvbfFdbCqHrlY13Qiz9g2eZ1vw1E@mail.gmail.com>
References: <AANLkTimMb_PshxAIDvbfFdbCqHrlY13Qiz9g2eZ1vw1E@mail.gmail.com>
Date: Thu, 22 Jul 2010 00:47:02 +0200
Message-Id: <20100721224702.89A12153A7F@gemini.denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dear Bradley Hughes,

In message <AANLkTimMb_PshxAIDvbfFdbCqHrlY13Qiz9g2eZ1vw1E@mail.gmail.com> you wrote:
> This version uses "fsl,mpc8555..." instead of "fsl,85..." notation.

Such comments should go below the "---" line.

> There is also an 8541 version of this board so DTS for this board
> is specific to the 8555 processor.
> 
> Another patch is coming to fix-up other DTS that use old notation.

Ditto.

> Signed-off-by: Bradley Hughes <bhughes@silicontkx.com>
> ---
^^^^^^^  Insert comments after this line.

Hm... have you verified that PCI is working? I tried enabling drivers
for the ITE8211 PATA controller, but it doesn't seem to work for me
(and yes, I did add the required "pata_it821x.noraid=1" to the
bootargs).

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
To be a winner, all you need to give is all you have.
