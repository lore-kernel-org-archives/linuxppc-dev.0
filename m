Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6212AB714B
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 16 Jun 2009 13:18:26 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BC640DDD04
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Jun 2009 13:18:25 +1000 (EST)
Message-Id: <8FC8CF07-082B-404C-9767-D5FA03CD1AE9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: hs@denx.de
In-Reply-To: <4A35FA6A.60004@denx.de>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: [PATCH v5] 83xx: add support for the kmeter1 board.
Date: Mon, 15 Jun 2009 22:16:14 -0500
References: <20090427180503.GB10292@ld0162-tx32.am.freescale.net>
	<49F68943.3090800@denx.de>
	<20090428163540.GA2193@ld0162-tx32.am.freescale.net>
	<49F7DC0C.3080409@denx.de>
	<C934E2FC-7597-4D10-AA2F-F28884D1DD1B@kernel.crashing.org>
	<4A30A14D.50907@denx.de>
	<0AFEA008-BBF6-448B-844F-6EBE3DE24F7B@kernel.crashing.org>
	<4A3148A1.3030403@denx.de> <20090612011332.GA9084@yookeroo.seuss>
	<4A31E74E.6090505@denx.de> <20090615024252.GC25444@yookeroo.seuss>
	<4A35FA6A.60004@denx.de>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jun 15, 2009, at 2:38 AM, Heiko Schocher wrote:

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
>    http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070804.html
>
> - Flash accessed via MTD layer
>
>  On this hardware there is an Intel P30 flash, following patch
>  series is necessary for working with this hardware:
>
>  http://lists.ozlabs.org/pipermail/linuxppc-dev/2009-April/070624.html
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
> changes since v3:
> - updated mailinglistarchivelinks for necessary patches in commit  
> text.
>
> changes since v4:
> - added comments from David Gibson
>
> $ ./scripts/checkpatch.pl 0001--83xx-add-support-for-the-kmeter1- 
> board.patch
> total: 0 errors, 0 warnings, 1636 lines checked
>
> 0001--83xx-add-support-for-the-kmeter1-board.patch has no obvious  
> style problems and is ready for submission.
> $
>
> Signed-off-by: Heiko Schocher <hs@denx.de>
> ---
> arch/powerpc/boot/dts/kmeter1.dts           |  520 +++++++++++++++
> arch/powerpc/configs/83xx/kmeter1_defconfig |  908 ++++++++++++++++++ 
> +++++++++
> arch/powerpc/platforms/83xx/Kconfig         |    7 +
> arch/powerpc/platforms/83xx/Makefile        |    1 +
> arch/powerpc/platforms/83xx/kmeter1.c       |  191 ++++++
> 5 files changed, 1627 insertions(+), 0 deletions(-)
> create mode 100644 arch/powerpc/boot/dts/kmeter1.dts
> create mode 100644 arch/powerpc/configs/83xx/kmeter1_defconfig
> create mode 100644 arch/powerpc/platforms/83xx/kmeter1.c

applied to next

- k
