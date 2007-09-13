Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070913145236.GC32043@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070910032529.GA27828@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
	<20070911141907.GF1932@ld0162-tx32.am.freescale.net>
	<46B96294322F7D458F9648B60E15112C85D755@zch01exm26.fsl.freescale.net>
	<20070912151938.GA15561@ld0162-tx32.am.freescale.net>
	<fd81b53021e39a13ea65c0a0319aab77@kernel.crashing.org>
	<20070913145236.GC32043@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <45A974B9-31AF-46AB-B1CA-525F15BC5DDB@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Date: Thu, 13 Sep 2007 10:11:57 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>,
	paulus@samba.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 13, 2007, at 9:52 AM, Scott Wood wrote:

> On Thu, Sep 13, 2007 at 04:09:29AM +0200, Segher Boessenkool wrote:
>>>> I have a strange issue here. If I rename 'fsl,dma' to
>>>> 'fsl,mpc8540-dma',
>>>> the 'fsl,mpc8540-dma-channel' will be also regarded as DMA  
>>>> device not
>>>> DMA channel.

Have we closed on what the device-tree parts for this should look  
like?  I'd like to at least get those parts of this patch into my  
tree if possible for 2.6.24.

- k
