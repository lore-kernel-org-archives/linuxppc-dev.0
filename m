Return-Path: <tnt@246tNt.com>
Received: from outmx016.isp.belgacom.be (outmx016.isp.belgacom.be
	[195.238.2.115]) by ozlabs.org (Postfix) with ESMTP id D3BE167A64
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Mar 2005 05:38:03 +1100 (EST)
Received: from outmx016.isp.belgacom.be (localhost [127.0.0.1])
	by outmx016.isp.belgacom.be (8.12.11/8.12.11/Skynet-OUT-2.22) with
	ESMTP id j29Ibrra026092
	for <linuxppc-embedded@ozlabs.org>; Wed, 9 Mar 2005 19:37:53 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <422F4284.1050806@246tNt.com>
Date: Wed, 09 Mar 2005 19:37:56 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Andrey Volkov <avolkov@varma-el.com>
References: <422EEA20.4050907@varma-el.com>	<d32d7ad858d3660f9d7fdf33003ca4cc@freescale.com>
	<422F34F9.1050607@varma-el.com>
In-Reply-To: <422F34F9.1050607@varma-el.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: paulus@samba.org, linuxppc-embedded@ozlabs.org
Subject: Re: RFC/Commit: New ocp id for CANbus devs
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrey Volkov wrote:

> Hi Kumar:
>
>> Is this for 2.6?  
>
> Oh sorry, certainly for 2.6 (Sylvain's kernel more precisely).
> But since, Sylvain not maintainer of ocp_ids.h, so I send
> this patch to Paul (who create it, am I right?).
>
>> If so, 5200 needs to be moved to using the new driver model and 
>> platform devices.  Take a look at support for MPC85xx or marvell 
>> (mv64x60) as examples.
>>
>> - kumar
>
> Kumar, please, more cleanly, what did you want to say? If you told about
> board_ocp[] in lite5200.c (platform specific). Then yes, I use it, but 
> not mpc5200.c
>
No, what he said is that MPC5200 needs to be moved to use the platform 
bus driver model.

I'll post the patch doing just that on Monday along with PCI and sparse 
clean-ups. (Unless something goes wrong ...)


    Sylvain
