Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A32ECDDF00
	for <linuxppc-dev@ozlabs.org>; Tue, 16 Oct 2007 05:04:52 +1000 (EST)
Message-ID: <4713B9C1.5010001@garzik.org>
Date: Mon, 15 Oct 2007 15:04:33 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] PowerPC: Add BCM5248 and Marvell 88E1111 PHY support
	to NEW EMAC.
References: <20071015175717.GA4602@ru.mvista.com>	<4713B10B.5000607@garzik.org>	<20071015134813.6aacdcca@weaponx.rchland.ibm.com>	<4713B726.6080404@garzik.org>
	<20071015135959.5b603d7d@weaponx.rchland.ibm.com>
In-Reply-To: <20071015135959.5b603d7d@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Mon, 15 Oct 2007 14:53:26 -0400
> Jeff Garzik <jeff@garzik.org> wrote:
>>>> Seems sane to me -- ACK -- but we have multiple people sending me 
>>>> patches for a single driver.  That's normal for janitorial cleanups 
>>>> across the whole tree, but discouraged when multiple people are actively 
>>>> working on the same driver.
>>>>
>>>> Please coordinate, and have ONE person send me patches...
>>> Who else is sending you patches?  Valentine is the only one I've seen
>>> send patches recently...
>> It's a zoo :)
> 
> Wow, indeed.
> 
>> Al Viro (3):
>>        typo in ibm_newemac/rgmii.c
> 
> Val sent this as well.  Either one works.
> 
>>        skb->tail in ibm_newemac should be skb_tail_pointer()
>>        ibm_newemac annotations (iomem, NULL noise)
> 
> Ack on those.
> 
>> David Gibson (1):
>>        Device tree aware EMAC driver
> 
> That's the initial commit :)
> 
>> Michael Ellerman (3):
>>        Update ibm_newemac to use dcr_host_t.base
>>        Add dcr_host_t.base in dcr_read()/dcr_write()
>>        Use dcr_host_t.base in dcr_unmap()
> 
> Missed those, but I see you applied them which is good.
> 
>> Roland Dreier (2):
>>        ibm_new_emac: Nuke SET_MODULE_OWNER() use
>>        ibm_emac: Convert to use napi_struct independent of struct net_device
> 
> I never saw either of these.  I'm also beginning to wonder if one of
> them broke things because I can't currently get ibm_newemac to work.
> 
>> vbarshak@ru.mvista.com (1):
>>        Fix typo in new EMAC driver.
> 
> Same fix as Al's.

All those are what's upstream, except for the Michael Ellerman patches. 
  FWIW it was generated using

	git log drivers/net/ibm_newemac | git shortlog


> Anyway, we can queue patches to this through me if you'd like.

I would ideally like a single active patch generator (even if they are 
merely reviewed others work sometimes).

Outside of that, I'm hoping you and the other people listed making 
changes will self-organize without my help :)

	Jeff
