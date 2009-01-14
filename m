Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 906CFDE076
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Jan 2009 05:21:16 +1100 (EST)
Message-Id: <4DDB8462-ACB6-494A-A1CB-4F56668A4EE1@freescale.com>
From: Andy Fleming <afleming@freescale.com>
To: avorontsov@ru.mvista.com
In-Reply-To: <20090114150332.GA839@oksana.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH] phylib: Fix Freescale TBI PHY detection
Date: Wed, 14 Jan 2009 12:20:35 -0600
References: <20090113160513.GA22083@oksana.dev.rtsoft.ru>
	<20090114150332.GA839@oksana.dev.rtsoft.ru>
Cc: linuxppc-dev@ozlabs.org, Giulio Benetti <giulio.benetti@micronovasrl.com>,
	Jeff Garzik <jgarzik@pobox.com>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 14, 2009, at 9:03 AM, Anton Vorontsov wrote:
>>
>> There is one thing I don't actually understand though...
>>
>> Andy, were you testing the TBI support on a hardware where PHY ID
>> != 0x0 or maybe your TBI PHY support patch (commit b31a1d8b41513b,
>> dated Tue Dec 16 15:29:15 2008) was based on a bit outdated kernel
>> version? Because according to the git timestamps, the TBI support
>> was not working since the submission.
>>
>> Just in case, the hardware I'm seeing the PHY ID == 0x0 is
>> MPC8378E-MDS.
>
> I think I got it. Probably the TBI support patch was based on the
> powerpc.git next, and the commit that broke the TBI support
> was in the net-next-2.6 tree.
>
> That explains why nobody noticed the issue.


Yeah, I dropped the ball.  I saw the patch go in, thought that might  
break something, but I didn't find time to look into it.  Thanks for  
finding and reverting this bug.

Acked-by: Andy Fleming <afleming@freescale.com>
