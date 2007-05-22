Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 2478EDDE34
	for <linuxppc-dev@ozlabs.org>; Tue, 22 May 2007 22:56:24 +1000 (EST)
In-Reply-To: <46B96294322F7D458F9648B60E15112C2348C8@zch01exm26.fsl.freescale.net>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<B9B280B9-3F66-479B-ABB2-FD294EC25C7E@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C2348C8@zch01exm26.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <1F85E852-83D3-4B69-A658-F4BCE8B048A6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/5] Add the support for MPC8641 silicon rev 2.0 and
	MPC8641HPCN board 2.0
Date: Tue, 22 May 2007 07:54:40 -0500
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Cc: ppc-dev dev ML <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 21, 2007, at 11:46 PM, Zhang Wei-r63237 wrote:

> Hi, Kumar,
>
> Please see my inline comments:
>>>
>>>   [PATCH 1/5] Remove the errata fix codes for MPC8641 silicon ver
>>> 1.0 which is end of life.
>
> This patch is not included in Wade's patch.
>
> MPC8641 silicon 1.0 is end of life and not full following
> PCI/PCI-Express specifications.
> Rev 2.0 silicon fixes these PCI/PCI-Express errata and follows the
> PCI/PCI-Ex specifications.
> So, using generic PCI codes is okay.

Was rev1.0 silicon ever used by customers w/ production systems?

>>>   [PATCH 2/5] Add uli1575 pci-bridge sector to MPC8641HPCN dts file.
>
> This's a simple and clear solution to Wade's pci fix patch. Some  
> changes
> of Wade's pci fix patch are redundant.
>
>>>   [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
>
> This patch is not included in Wade's patch.
>
> Every PCI hose bus range number is started from 0 before. This patch
> make the hose bus range number is started from previous hose last bus
> number added one.
> And PCI-Ex tranining status check is added to avoid the system halt.
>
>>>   [PATCH 4/5] Set RC of mpc8641 to transparent bridge for transfer
>>> legacy I/O access.
>
> This patch is different than Wade's pci fix patch.
> Wade's pci patch changing MPC8641 PCI_CLASS property is not a good
> solution. Only set it to transport bridge is okay.
> And this quirk functions should applied to both MPC8641 and MPC8641D,
> not only dual core version.
>
>>>   [PATCH 5/5] Set IDE in ULI1575 to not native mode.
>
> This patch is not included in Wade's patch.
> It makes IDE in ULI1575 works.
>
>>
>> How do these patches differ/interace from what Wade posted a
>> few days
>> ago?
>
> Wade's MTD patch (patch 1), Legacy patch (patch 2), superIO patch  
> (patch
> 3), RTC patch (patch 4) is not overlap with my patches.
> But Wade's PCI patch (patch 5) most of codes is for supporting a
> discontinued and end of life silicon and I do not agree with the  
> changes
> about PCI_CLASS of MPC8641. The dts fixing is too complex. I  
> suggest to
> reject Wade's PCI patch.

Is Wade going to rebase his patches on top of your's?

- k
