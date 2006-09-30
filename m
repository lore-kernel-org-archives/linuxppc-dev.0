Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EB5F867BC2
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Sep 2006 15:06:34 +1000 (EST)
In-Reply-To: <4879B0C6C249214CBE7AB04453F84E4D19DB0D@zch01exm20.fsl.freescale.net>
References: <4879B0C6C249214CBE7AB04453F84E4D19DB0D@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0D9B8CAD-6D9D-4A20-A0C5-C2ECA45595E9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/9] qe_lib: Add QE SoC support
Date: Sat, 30 Sep 2006 00:06:58 -0500
To: Li Yang-r58472 <LeoLi@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sep 29, 2006, at 11:37 PM, Li Yang-r58472 wrote:

>
>> -----Original Message-----
>> From: Kumar Gala [mailto:galak@kernel.crashing.org]
>> Sent: Friday, September 29, 2006 10:13 PM
>> To: Li Yang-r58472
>> Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
>> Subject: Re: [PATCH 6/9] qe_lib: Add QE SoC support
>>
>>
>> On Sep 29, 2006, at 5:35 AM, Li Yang wrote:
>>
>>> Signed-off-by: Li Yang <leoli@freescale.com>
>>> Signed-off-by: Kim Phillips <kim.phillips@freescale.com>
>>>
>>> ---
>>>  arch/powerpc/sysdev/qe_lib/qe.c |  176 ++++++++++++++++++++++++++++
>>> +++++++++++
>>>  include/linux/fsl_devices.h     |   39 ++++++++-
>>>  2 files changed, 214 insertions(+), 1 deletions(-)
>>
>> As I've stated in the past make this use of_device instead of
>> platform_device.
>
> As I've argued before, there are currently many off-the-tree user  
> of ppc
> arch on 8360, and we must still support that.  Change the ucc_geth
> driver to use of_device will add the effort of maintaining two  
> versions
> of ucc_geth driver for us (one for ppc, one for powerpc).  Do you  
> really
> think it is so important to replace platform_device with of_device?  I
> didn't see any true benefit of doing so.

I dont see why you need to maintain an arch/ppc version as everything  
related to 8360 is arch/powerpc.  If you guys have some internal  
stuff that is your own issue to manage.  This is a new device and  
thus should use of_device.  My goal is to eventually move the other  
users of platform_device over to of_device when they aren't being  
sured with arch/ppc in the public tree.

- kumar
