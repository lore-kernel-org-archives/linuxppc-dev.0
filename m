Return-Path: <randy.dunlap@oracle.com>
Received: from rgminet01.oracle.com (rgminet01.oracle.com [148.87.113.118])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3B3F2DDEFA
	for <linuxppc-dev@ozlabs.org>; Wed, 12 Sep 2007 00:21:39 +1000 (EST)
Message-ID: <46E6A419.9070101@oracle.com>
Date: Tue, 11 Sep 2007 07:20:09 -0700
From: Randy Dunlap <randy.dunlap@oracle.com>
MIME-Version: 1.0
To: Zhang Wei-r63237 <Wei.Zhang@freescale.com>
Subject: Re: [PATCH 5/5] Add DMA engine driver for Freescale MPC85xx
	processors.
References: <11891624582950-git-send-email-wei.zhang@freescale.com>
	<20070907085845.54dc88f8.randy.dunlap@oracle.com>
	<46B96294322F7D458F9648B60E15112C85D61C@zch01exm26.fsl.freescale.net>
In-Reply-To: <46B96294322F7D458F9648B60E15112C85D61C@zch01exm26.fsl.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Cc: shannon.nelson@intel.com, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, paulus@samba.org, dan.j.williams@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Zhang Wei-r63237 wrote:

>>> +/**
>>> + * fsl_chan_xfer_ld_queue -- Transfer the link descriptors 
>> in channel
>>> + *                           ld_queue.
>> The function's "short description" (unfortunately) must be on only one
>> line.  E.g.:
>>
>>  * fsl_chan_xfer_ld_queue - Transfer link descriptors in 
>> channel ld_queue.
>>
> 
> How about it's length greater than 80?

If it's close to 80+, you can just leave it like that.
If it's much longer, you can use this format:

/**
 * function_name - short description
 * @parameters: prm description
 *
 * Longer
 *      function
 *             description.
 */



Thanks,
~Randy
