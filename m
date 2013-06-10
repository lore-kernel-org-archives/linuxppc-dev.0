Return-Path: <imr@rtschenk.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 153082C016F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 21:42:03 +1000 (EST)
From: Rojhalat Ibrahim <imr@rtschenk.de>
To: Michael Guntsche <michael.guntsche@it-loops.com>
Subject: Re: [BUG] PCI related panic on powerpc based board with 3.10-rcX
Date: Mon, 10 Jun 2013 13:41:52 +0200
Message-ID: <7927838.NMrLdRWptT@pcimr>
In-Reply-To: <CALG0vJu9-640D=Q-2RoSOnWtR=sERwj0fSCibK+ijprcf-T6Ag@mail.gmail.com>
References: <CALG0vJu9-640D=Q-2RoSOnWtR=sERwj0fSCibK+ijprcf-T6Ag@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Mike,

could you please try this patch:
https://lists.ozlabs.org/pipermail/linuxppc-dev/2013-May/106624.html
http://patchwork.ozlabs.org/patch/244515/

   Rojhalat


On Saturday 08 June 2013 21:39:37 Michael Guntsche wrote:
> After bisecting I found the responsible commit.
> 
> 50d8f87d2b3: powerpc/fsl-pci Make PCIe hotplug work with Freescale
> PCIe controllers
> 
> Reverting this commit allowed my board to boot again.
> 
> @Rojhalat: Please have a look at
> http://marc.info/?l=linux-kernel&m=137071294204858&w=2
> for my initial bugreport.
> 
> What I do not understand at all is why this is affecting my platform.
> AFAIK there is no PCIe hardware on it AND I completely disabled PCIe
> support in config.
> 
> Kind regards,
> Mike
