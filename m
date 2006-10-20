Return-Path: <afleming@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id CADF5679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 10:55:01 +1000 (EST)
In-Reply-To: <02d901c6f3cf$8952e990$1267a8c0@Jocke>
References: <02d901c6f3cf$8952e990$1267a8c0@Jocke>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A72FC7DA-57CF-4D5A-BBE5-0DE5E6BD29BE@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Subject: Re: [PATCH] Slight refactor of interrupt mapping for FSL parts
Date: Thu, 19 Oct 2006 19:54:59 -0500
To: Joakim Tjernlund <joakim.tjernlund@transmode.se>
Cc: linuxppc-dev@ozlabs.org, 'Jeff Garzik' <jgarzik@pobox.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>
>>
>> PHY_IGNORE_INTERRUPT means that the PHY Lib will not poll the
>> interface, nor will it register for the interrupt.  Actually, it
>> would be best for a dummy PHY driver.  Take a look at the driver in
>> drivers/phy/fixed.c.  It's there to provide that kind of interface.
>> It looks like it uses -1, which is a problem, but my revision
>> of this
>> patch will fix that.
>
> Great, thanks. I don't see how to connect this PHY to ucc_geth  
> driver yet. I think
> it needs some PHY work first.
>
> Maybe this patch,http://ozlabs.org/pipermail/linuxppc-dev/2006- 
> October/026690.html, will make it better?
> Why hasn't it been applied yet?


No, there's a bigger issue.  The UCC driver has not been brought over  
to the PHY Layer.  Hopefully, this will be rectified in short order.

Andy
