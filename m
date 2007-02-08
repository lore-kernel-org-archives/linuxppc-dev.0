Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C11A4DDEBC
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 08:48:35 +1100 (EST)
In-Reply-To: <Pine.LNX.4.60.0612120039470.4039@poirot.grange>
References: <Pine.LNX.4.60.0612012241430.13326@poirot.grange>
	<200612021156.37067.arnd@arndb.de>
	<1165058392.22108.34.camel@localhost.localdomain>
	<Pine.LNX.4.60.0612120039470.4039@poirot.grange>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <222713BC-A66F-460E-ABAD-DFE967EB259F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] linkstation / kurobox support
Date: Thu, 8 Feb 2007 15:47:28 -0600
To: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
Cc: Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd@arndb.de>,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 28, 2007, at 4:31 PM, Guennadi Liakhovetski wrote:

> On Sat, 2 Dec 2006, Benjamin Herrenschmidt wrote:
>
>> On Sat, 2006-12-02 at 11:56 +0100, Arnd Bergmann wrote:
>>
>>>> +#ifdef CONFIG_BLK_DEV_INITRD
>>>> +       if (initrd_start)
>>>> +               ROOT_DEV = Root_RAM0;
>>>> +       else
>>>> +#endif
>>>> +#ifdef CONFIG_ROOT_NFS
>>>> +               ROOT_DEV = Root_NFS;
>>>> +#else
>>>> +               ROOT_DEV = Root_HDA1;
>>>> +#endif
>>>> +
>>>
>>> This looks wrong. Didn't the same code come up recently in a  
>>> review for
>>> another platform? What was the conclusion?
>>
>> It's a copy paste that we inhertit from the big bang...  Should  
>> probably
>> go...
>
> ...and there it goes. Re-diffed against 2.6.20-rc6. For inclusion in
> 2.6.21.
>
> Thanks
> Guennadi
> ---
> Guennadi Liakhovetski
>
> Linkstation systems capable of running mainline kernels use u-boot  
> as a
> bootloader, so, specifying a suitable kernel command is not a problem.
> Don't guess. Also extend linkstation_defconfig to support the  
> linkstation HS
> model with a IT8212 IDE controller and kuroboxHD/HD-HLAN linkstation
> models with a tulip ethernet chip. The latter also require a slightly
> different .dts file, which is also included with this patch.
>
> Signed-off-by: Guennadi Liakhovetski <g.liakhovetski@gmx.de>

applied

- k
