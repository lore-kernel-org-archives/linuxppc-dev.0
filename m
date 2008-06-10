Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F1B60DDEE8
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Jun 2008 15:16:43 +1000 (EST)
Message-Id: <7B2677EE-5A72-4DE8-A550-8901503E122F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: akpm@linux-foundation.org
In-Reply-To: <200806092329.m59NTt1s014465@imap1.linux-foundation.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [patch 1/1] fsldma: the MPC8377MDS board device tree node for
	fsldma driver
Date: Tue, 10 Jun 2008 00:16:19 -0500
References: <200806092329.m59NTt1s014465@imap1.linux-foundation.org>
Cc: shannon.nelson@intel.com, linuxppc-dev@ozlabs.org, paulus@samba.org,
	scottwood@freescale.com, galak@gate.crashing.org,
	dan.j.williams@intel.com, leoli@freescale.com, wei.zhang@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 9, 2008, at 6:29 PM, akpm@linux-foundation.org wrote:

> From: Zhang Wei <wei.zhang@freescale.com>
>
> The fsldma driver is tested on MPC8377MDS board.  The patch adds  
> fsldma driver
> support into MPC8377MDS device tree.
>
> Signed-off-by: Zhang Wei <wei.zhang@freescale.com>
> Cc: "Nelson, Shannon" <shannon.nelson@intel.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Kumar Gala <galak@gate.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Scott Wood <scottwood@freescale.com>
> Cc: Li Yang <leoli@freescale.com>
>
> On Wed, 14 May 2008 18:28:08 -0500
> Scott Wood <scottwood@freescale.com> wrote:
>
>
>> akpm@linux-foundation.org wrote:
>>> From: Zhang Wei <wei.zhang@freescale.com>
>>>
>> According to booting-without-of.txt, the interrupts property should  
>> be
>> repeated in each channel.  The driver also needs to be fixed to  
>> remember
>> whether it registered a DMA-block-level interrupt handler already,  
>> and
>> not try to register a channel interrupt.
>
> Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
> ---
>
> arch/powerpc/boot/dts/mpc8377_mds.dts |   27 ++++++++++++++++++++++++
> 1 file changed, 27 insertions(+)

This is already in Linus's tree as commit  
3f346935f4f7141b0253ab0d8dfefb6e20ad08c3

- k
