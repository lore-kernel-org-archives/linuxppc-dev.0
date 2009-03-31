Return-Path: <beckyb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 09CCEDDE0D
	for <linuxppc-dev@ozlabs.org>; Wed,  1 Apr 2009 07:04:21 +1100 (EST)
Message-Id: <61576250-3589-4D1D-9335-30AA27BD3620@kernel.crashing.org>
From: Becky Bruce <beckyb@kernel.crashing.org>
To: Eduard Fuchs <edfuchs@uni-kassel.de>
In-Reply-To: <200903311706.55478.edfuchs@uni-kassel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: 8641D with linux 2.6.29 did'n show second cpu
Date: Tue, 31 Mar 2009 15:04:17 -0500
References: <200903311215.55237.edfuchs@uni-kassel.de>
	<446E5D82-7F37-42B5-8AD9-F8F368A5520A@kernel.crashing.org>
	<200903311706.55478.edfuchs@uni-kassel.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mar 31, 2009, at 10:06 AM, Eduard Fuchs wrote:

> Hi,
>
> Am Dienstag 31 M=E4rz 2009 15:20:21 schrieb Kumar Gala:
>> On Mar 31, 2009, at 5:15 AM, Eduard Fuchs wrote:
>>> Hi,
>>>
>>> I'm testing the evaluation board from freescale (MPC8641DHPCN) with
>>> the latest
>>> linux kernel (2.6.29) and the second core seems disabled. CONFIG_SPM
>>> is
>>> enabled but the /proc/cpuinfo shows only one cpu. With original
>>> 2.6.27 kernel
>>> both cpu cores appears in /proc/cpuinfo.
>>>
>>> Has anyone an idea how can i enable the second core?
>>
>> Are you using u-boot?  I can't remember if you need a newer u-boot to
>> deal with changes in how we bring up the second core.
>
> Yes. My u-boot version is 2009.03. Are there some additional config =20=

> keys for
> SMP support in u-boot?

Hrm, I am able to reproduce this here - the second processor is =20
reported as stuck and once we're booted, I only see one CPU online.  =20
Let me poke around and see if I can figure out what's going on here.

Cheers,
Becky
