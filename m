Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B4F28682C5
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Sep 2005 05:29:02 +1000 (EST)
In-Reply-To: <580ff9f6f516e94ae546c695bad0071c@embeddededge.com>
References: <580ff9f6f516e94ae546c695bad0071c@embeddededge.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <D91A246D-C79B-4B13-A512-4F5CCF7C8399@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 16 Sep 2005 14:29:12 -0500
To: Dan Malek <dan@embeddededge.com>
Cc: "Gala Kumar K.-galak" <galak@freescale.com>,
	linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: bseip config doesn't build
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Sep 16, 2005, at 12:34 PM, Dan Malek wrote:

>
> On Sep 16, 2005, at 12:41 PM, Kumar Gala wrote:
>
>
>> Anyone have any ideas why the bseip_defconfig doesnt build.  I get  
>> the
>> following error:
>>
>
> I'll look into it.
>
>
>>   CC      arch/ppc/8xx_io/enet.o
>>
>
> I thought we are should be using the drivers/net/* version of this?

I think that is the longer term plan.  I believe at this point we are  
still using 8xx_io/enet.c.  Not sure how this broken and it might be  
a simple defconfig update that is required.

thanks for looking into it.

- kumar
