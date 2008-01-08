Return-Path: <lg@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (unknown [80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id D9C5FDDE19
	for <linuxppc-dev@ozlabs.org>; Tue,  8 Jan 2008 23:45:02 +1100 (EST)
Subject: Re: [PATCH 0/2] ASoC drivers for the Freescale MPC8610 SoC
From: Liam Girdwood <lg@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1199732204949-git-send-email-timur@freescale.com>
References: <1199732204949-git-send-email-timur@freescale.com>
Content-Type: text/plain
Date: Tue, 08 Jan 2008 12:38:12 +0000
Message-Id: <1199795892.19903.74.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2008-01-07 at 12:56 -0600, Timur Tabi wrote:
> These patches add ALSA SoC device drivers for the Freescale MPC8610 SoC
> and the MPC8610-HPCD reference board.
> 
> The first patch updates some files in arch/powerpc and booting-without-of.txt.
> 
> The second patch adds the new audio driver files to sound/soc.
> 
> Both must be applied in order to avoid a build break.
> 
 
Both applied to the dev branch. This should let others use them atm and
allow us to port to ASoC v2.

I'll make a start on the port now.

Liam
