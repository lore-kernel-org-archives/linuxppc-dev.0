Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DFD5ADDEC6
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 05:00:01 +1000 (EST)
Message-ID: <46E9887D.3090200@freescale.com>
Date: Thu, 13 Sep 2007 13:59:09 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/5] Add Freescale DMA and DMA channel to
	Documentation/powerpc/booting-without-of.txt file.
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
	<045c872e8a912921da3259586595c0f3@kernel.crashing.org>
In-Reply-To: <045c872e8a912921da3259586595c0f3@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

Segher Boessenkool wrote:
>>>> What tree are you using?  Commit
>>>> 804ace8881d211ac448082e871dd312132393049
>>>> in Paul's git tree should have fixed that.
>>>
>>> Strange, I don't see that commit -- maybe gitweb is broken, or
>>> maybe the patch was superseded, or maybe it just disappeared?
>>> It's still shown in patchworks with this commit id fwiw.
>>
>> I see it here:
>> http://git.kernel.org/?p=linux/kernel/git/paulus/powerpc.git;a=commit;h=804ace8881d211ac448082e871dd312132393049 
>>
> 
> Ah okay.  The gitweb search functionality is broken.
> 
> Shouldn't this patch have gone to .23?  It's a pretty important
> bugfix I think.

Probably not, in the absence of a specific failing match that's already 
in .23.  It has the potential to break things that were working by chance.

-Scott
