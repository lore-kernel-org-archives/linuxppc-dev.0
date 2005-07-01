Return-Path: <kumar.gala@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102]) by ozlabs.org (Postfix) with ESMTP id B499867BA6
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 23:59:34 +1000 (EST)
In-Reply-To: <1835.1120206984@gerd>
References: <1835.1120206984@gerd>
Mime-Version: 1.0 (Apple Message framework v730)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5908D310-31E5-4B32-AF99-27FEB448A600@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Fri, 1 Jul 2005 08:59:28 -0500
To: <Murray.Jensen@csiro.au>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Well, this goes back to my comment on there not being a set of  
generic kernel APIs for general purpose DMA engines.

Otherwise, I'd rather leave this out of the kernel proper.

- kumar

On Jul 1, 2005, at 3:36 AM, <Murray.Jensen@csiro.au> wrote:

> On Fri, 01 Jul 2005 09:54:44 +0200, Clemens Koller writes:
>
>> Is there any interest to publish this and the other patches
>> and get it into 2.6 if not already planned?
>>
>
> Well, I'd certainly be interested. Cheers!
>
> Murray...
> -- 
> Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3  
> 9662
> 7763
> Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3  
> 9662
> 7853
> Internet: Murray.Jensen@csiro.au
>
> To the extent permitted by law, CSIRO does not represent, warrant  
> and/or
> guarantee that the integrity of this communication has been maintained
> or
> that the communication is free of errors, virus, interception or
> interference.
>
> The information contained in this e-mail may be confidential or
> privileged.
> Any unauthorised use or disclosure is prohibited. If you have received
> this
> e-mail in error, please delete it immediately and notify Murray Jensen
> on
> +61 3 9662 7763. Thank you.
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>
