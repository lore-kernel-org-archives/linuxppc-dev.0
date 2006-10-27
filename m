Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id 270E867D87
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Oct 2006 00:50:49 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	k9RF4LNU001053
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 08:04:21 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id k9REojFL010493
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Oct 2006 09:50:47 -0500 (CDT)
Subject: Re: [PATCH] Powerpc:  Make pci_read_irq_line the default: on
	mpc7448hpc2 board
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <1161949906.25263.19.camel@localhost.localdomain>
References: <1161141538.24931.9.camel@localhost.localdomain>
	<1161949906.25263.19.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1161960682.25801.4.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 27 Oct 2006 22:51:22 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	"Alexandre.Bounine@tundra.com" <Alexandre.Bounine@tundra.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2006-10-27 at 19:51, Zang Roy-r61911 wrote:
> The following patch updates the tsi108/9 pci interrupt controller code
> on mpc7448hpc2 board.
> 
> The patch should apply after Ben's patch 
> http://ozlabs.org/pipermail/linuxppc-dev/2006-October/027287.html
> 
> Of course, the mpc7448hpc2 part in that patch should be replaced by this
> one :-).
> 
Missed the following line :-)

Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>

> ---
>  arch/powerpc/boot/dts/mpc7448hpc2.dts             |   44 ++++++----
>  arch/powerpc/platforms/embedded6xx/mpc7448_hpc2.c |   96 +++++----------------
>  arch/powerpc/sysdev/tsi108_pci.c                  |   63 ++++++++++++--
>  3 files changed, 108 insertions(+), 95 deletions(-)
