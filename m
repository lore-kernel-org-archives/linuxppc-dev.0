Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 9A12FDE118
	for <linuxppc-dev@ozlabs.org>; Sat, 27 Jan 2007 02:08:10 +1100 (EST)
Message-ID: <45BA1952.80206@freescale.com>
Date: Fri, 26 Jan 2007 09:08:02 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Add support for the MPC8349E-mITX-GP
References: <11691560171514-git-send-email-timur@freescale.com>
	<309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>
In-Reply-To: <309FC1DE-9724-4172-BB13-D301D4A783F8@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Jan 18, 2007, at 3:33 PM, Timur Tabi wrote:
> 
>> Adds support for the MPC8349E-mITX-GP, which is a stripped-down version
>> of the MPC8349E-mITX reference board from Freescale.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>> ---
>>  arch/powerpc/boot/dts/mpc8349emitx-gp.dts     |  190 ++++
>>  arch/powerpc/configs/mpc834x_itx_gp_defconfig | 1422 
>> +++++++++++++++++++++++++
>>  2 files changed, 1612 insertions(+), 0 deletions(-)
> 
> Why does the defconfig differ so much from the mpc834x_itx_defconfig?

I just did a "make mpc834x_itx_defconfig" and used "make menuconfig" to change a 
couple options, then did a save.  My guess is that when menuconfig rewrote the 
file, it made major changes, including new defaults for the 2.6.19-whatever kernel.

Was I supposed to hand-edit the config file to make the minimum number of changes?

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
