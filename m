Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id D0913B70E9
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 00:13:03 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id ED3A3DDD01
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jun 2009 00:13:02 +1000 (EST)
Message-Id: <0AFEA008-BBF6-448B-844F-6EBE3DE24F7B@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4A30A14D.50907@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v3] 83xx: add support for the kmeter1 board.
Date: Thu, 11 Jun 2009 09:10:52 -0500
References: <49F00605.1080605@denx.de>
	<6B76A454-649E-408C-A8DF-AAEEE6011929@kernel.crashing.org>
	<49F544DE.1010307@denx.de>
	<20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
	<20090428163540.GA2193@ld0162-tx32.am.freescale.net>
	<49F7DC0C.3080409@denx.de>
	<C934E2FC-7597-4D10-AA2F-F28884D1DD1B@kernel.crashing.org>
	<4A30A14D.50907@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 11, 2009, at 1:16 AM, Heiko Schocher wrote:

> The following series implements basic board support for
> the kmeter1 board from keymile, based on a MPC8360.
>
> This series provides the following functionality:
>
> - The board can boot with a serial console on UART1
> - Ethernet:
>    UCC1 in RGMII mode
>    UCC2 in RGMII mode
>    UCC4 in RMII mode
>    UCC5 in RMII mode
>    UCC6 in RMII mode
>    UCC7 in RMII mode
>    UCC8 in RMII mode
>
>    following patch is necessary for working UCC in RMII mode:
>
>    http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070909.html
>
> - Flash accessed via MTD layer
>
>  On this hardware there is an Intel P30 flash, following patch
>  series is necessary for working with this hardware:
>
>  http://ozlabs.org/pipermail/linuxppc-dev/2009-April/070716.html

the links are stale since the ozlabs.org rebuilt and moved the  
maillist.. mind updating.

>
>
> - I2C using I2C Bus 1 from the MPC8360 cpu
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> changes since v1:
> - added comments from Kumar Gala and Scott Wood
> - get rid of using get_immrbase() in board specific code
>
> changes since v2:
> - added comments from Kumar Gala
> - rebased against 1406de8e11eb043681297adf86d6892ff8efc27a
>  from git://git.kernel.org/pub/scm/linux/kernel/git/galak/powerpc.git
>
> $ ./scripts/checkpatch.pl 0001--83xx-add-support-for-the-kmeter1- 
> board.patch
> total: 0 errors, 0 warnings, 1618 lines checked
>
> 0001--83xx-add-support-for-the-kmeter1-board.patch has no obvious  
> style problems and is ready for submission.
> $
