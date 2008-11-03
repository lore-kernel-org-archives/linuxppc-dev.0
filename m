Return-Path: <kumar.gala@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 90706DDD0B
	for <linuxppc-dev@ozlabs.org>; Tue,  4 Nov 2008 07:38:29 +1100 (EST)
Message-Id: <5F0C4A97-EA35-4235-9457-FC44D4906E2D@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
To: Nate Case <ncase@xes-inc.com>
In-Reply-To: <1225738532.27415.237.camel@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] gianfar: Omit TBI auto-negotiation based on device tree
Date: Mon, 3 Nov 2008 14:38:15 -0600
References: <1225234382-23050-1-git-send-email-ncase@xes-inc.com>
	<Pine.LNX.4.64.0810301738020.3943@t2.domain.actdsltmp>
	<1225738532.27415.237.camel@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Andy Fleming <afleming@freescale.com>,
	Trent Piepho <tpiepho@freescale.com>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 3, 2008, at 12:55 PM, Nate Case wrote:

> On Thu, 2008-10-30 at 18:07 -0700, Trent Piepho wrote:
>> But more relevant to your serdes problem, I also have a patch that
>> prevents
>> restarting serdes auto-negotiation if the serdes link is already up.
>> My SGMII
>> PHY will auto-negotiate, but it takes about 3 seconds.  Avoiding an
>> unnecessary 3 second auto-negotiation when the gianfar device is
>> opened lets
>> me cut my power-on to DHCP completion time in half.
>>
>> I wonder if this would also fix your problem, without needing to add
>> the extra
>> workaround?
>
> I just verified that your patch solves my problem without the need for
> my workaround.  So at this point, it looks like we can drop this patch
> ("Omit TBI auto-negotiation based on device tree").
>
> I tested when booting the kernel in U-Boot both via both TFTP and  
> flash
> (I was worried that your patch may only fix things for the TFTP boot
> case, but that wasn't the case fortunately).
>
> Thanks for the patch!

Ok, marked Nate's patch as superseded in patchworks.

- k
