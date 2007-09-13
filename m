Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070912151938.GA15561@ld0162-tx32.am.freescale.net>
References: <11891624353752-git-send-email-wei.zhang@freescale.com>
	<1189162437484-git-send-email-wei.zhang@freescale.com>
	<3b29878a7d3d1b14f84b5d3b182cdb98@kernel.crashing.org>
	<20070910032529.GA27828@localhost.localdomain>
	<46B96294322F7D458F9648B60E15112C85D61B@zch01exm26.fsl.freescale.net>
	<20070911141907.GF1932@ld0162-tx32.am.freescale.net>
	<46B96294322F7D458F9648B60E15112C85D755@zch01exm26.fsl.freescale.net>
	<20070912151938.GA15561@ld0162-tx32.am.freescale.net>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <fd81b53021e39a13ea65c0a0319aab77@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
Date: Thu, 13 Sep 2007 04:09:29 +0200
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>,
	paulus@samba.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I have a strange issue here. If I rename 'fsl,dma' to 
>> 'fsl,mpc8540-dma',
>> the 'fsl,mpc8540-dma-channel' will be also regarded as DMA device not
>> DMA channel.
>
> What tree are you using?  Commit 
> 804ace8881d211ac448082e871dd312132393049
> in Paul's git tree should have fixed that.

Strange, I don't see that commit -- maybe gitweb is broken, or
maybe the patch was superseded, or maybe it just disappeared?
It's still shown in patchworks with this commit id fwiw.


Segher
