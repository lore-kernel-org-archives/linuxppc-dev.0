Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 59F68DDE42
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 03:17:57 +1100 (EST)
In-Reply-To: <20070206152442.GB21050@lixom.net>
References: <20070125073754.GA10004@lixom.net>
	<17864.25011.534976.210942@cargo.ozlabs.ibm.com>
	<01A15290-2EA9-454A-8DD5-28A01E39862B@kernel.crashing.org>
	<20070206152442.GB21050@lixom.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <91DAA7F5-2893-45CC-A920-2B3746D71DF9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] generic RTC support for PPC
Date: Tue, 6 Feb 2007 10:16:55 -0600
To: Olof Johansson <olof@lixom.net>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	kimphill@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 6, 2007, at 9:24 AM, Olof Johansson wrote:

> On Tue, Feb 06, 2007 at 08:40:33AM -0600, Kumar Gala wrote:
>>
>> On Feb 6, 2007, at 5:08 AM, Paul Mackerras wrote:
>>
>>> Olof Johansson writes:
>>>
>>>> Make the PPC RTC functions use the generic RTC infrastructure if  
>>>> they
>>>> are not already defined (and an RTC is registered in the system).
>>>>
>>>> This should make it possible to remove the hideous direct access  
>>>> used
>>>> in some of the 83xx platforms.
>>>
>>> What was the consensus in the end about this?  Should it go in for
>>> 2.6.21?
>>
>> Are the "scheduling while atomic" issues that existed before actually
>> been fixed?
>>
>> http://marc.theaimsgroup.com/?l=linux-kernel&m=116378523012349&w=2
>
> My patch shouldn't do it since it uses a work queue, but that bug  
> report
> was for the rtc class api instead of genrtc. It'll need something  
> similar.
>
> I can't even find the rtc_class_hookup code in 2.6.20, so I'm not sure
> just what he was running.

Not 100% sure but we did back out some of the patches to arch/powerpc  
code related to this.

- k
