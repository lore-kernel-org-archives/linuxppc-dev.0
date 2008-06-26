Return-Path: <galak@kernel.crashing.org>
Message-Id: <D0B930D5-3211-4199-94B9-586065A0F116@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Wolfgang Grandegger <wg@grandegger.com>
In-Reply-To: <4863A424.5080904@grandegger.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v924)
Subject: Re: [PATCH] [POWERPC] 85xx: TQM8548: add missing support for RTC and
	LM75
Date: Thu, 26 Jun 2008 09:15:32 -0500
References: <4863967F.8060806@grandegger.com>
	<D6CBABD3-569E-4BED-894C-4F86696E4DD6@kernel.crashing.org>
	<4863A424.5080904@grandegger.com>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 26, 2008, at 9:13 AM, Wolfgang Grandegger wrote:

> Kumar Gala wrote:
>> On Jun 26, 2008, at 8:15 AM, Wolfgang Grandegger wrote:
>>> It adds the missing RTC node to tqm8548.dts and enables support for
>>> I2C, DS1307 and LM75 in the default configuration.
>>>
>>> Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
>>> ---
>>> arch/powerpc/boot/dts/tqm8548.dts           |    5 arch/powerpc/ 
>>> configs/85xx/tqm8548_defconfig |  143 ++++++++++++++++++++++++++--
>>> 2 files changed, 142 insertions(+), 6 deletions(-)
>> your mailer is wrapping things.
>
> Hm, I can apply the patch extracted from my mail without problems.
>
>> Also, can you test out the mpc85xx_defconfig and make sure it works  
>> with the tqm85xx boards (and provide a second patch that enables  
>> whatever drivers you need in there)
>
> OK, will do so beginning of next week. For the TQM8548 I use the  
> ELDK ppc_85xxDP and for all others the ppc_85xx tool chain. Does a  
> mixed image for both types of MPC85xx CPUs make sense?

I'm just trying to keep the mpc85xx_defconfig as a subset of all the  
other defconfigs for 85xx so it gives people doing testing one  
defconfig to build and try and sure that the other defconfigs will  
continue to work.

- k
