Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6036ADE0C1
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 02:23:42 +1100 (EST)
In-Reply-To: <45BA1952.80206@freescale.com>
References: <11691560171514-git-send-email-timur@freescale.com>
	<309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>
	<45BA1952.80206@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <EC5E5BA9-F865-40AC-8CA8-9B152AAC0908@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for the MPC8349E-mITX-GP
Date: Fri, 26 Jan 2007 09:22:43 -0600
To: Timur Tabi <timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 26, 2007, at 9:08 AM, Timur Tabi wrote:

> Kumar Gala wrote:
>> On Jan 18, 2007, at 3:33 PM, Timur Tabi wrote:
>>> Adds support for the MPC8349E-mITX-GP, which is a stripped-down  
>>> version
>>> of the MPC8349E-mITX reference board from Freescale.
>>>
>>> Signed-off-by: Timur Tabi <timur@freescale.com>
>>> ---
>>>  arch/powerpc/boot/dts/mpc8349emitx-gp.dts     |  190 ++++
>>>  arch/powerpc/configs/mpc834x_itx_gp_defconfig | 1422 ++++++++++++ 
>>> +++++++++++++
>>>  2 files changed, 1612 insertions(+), 0 deletions(-)
>> Why does the defconfig differ so much from the mpc834x_itx_defconfig?
>
> I just did a "make mpc834x_itx_defconfig" and used "make  
> menuconfig" to change a couple options, then did a save.  My guess  
> is that when menuconfig rewrote the file, it made major changes,  
> including new defaults for the 2.6.19-whatever kernel.
>
> Was I supposed to hand-edit the config file to make the minimum  
> number of changes?

I did this as well, I'm talking about the debug options being  
different and USB support.  (Not simple diffs handled by make  
menuconfig).

- k
