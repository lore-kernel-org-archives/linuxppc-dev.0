Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0787667B58
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Jul 2006 23:51:50 +1000 (EST)
In-Reply-To: <86EC6E02268B3D4BA41C1B0C61FB14E60B4553CE@mdcexc01.na.ops.local>
References: <86EC6E02268B3D4BA41C1B0C61FB14E60B4553CE@mdcexc01.na.ops.local>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <C97DE3E9-F0BE-48CC-AE1A-D94713471098@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: export-objs in spi Makefile broke in latest linuxppc_2_4_deve l
	[r eposted]?
Date: Thu, 20 Jul 2006 08:52:05 -0500
To: "Rowan, Chad" <Chad.Rowan@thyssenkrupp.com>
Cc: hs@denx.de, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jul 20, 2006, at 8:38 AM, Rowan, Chad wrote:

> Why should this be taken off list?  Is it because it's Denx  
> specific?  Or
> because it's 2.4 specific?  There is active 5200 development on the  
> 2.4
> kernel at Denx and it seems relevant to this list.

Because its Denx specific, I believe the tree you are taking about is  
maintained only by Denx and not a community tree.

- k

> -----Original Message-----
> From: Kumar Gala [mailto:galak@kernel.crashing.org]
> Sent: Thursday, July 20, 2006 8:12 AM
> To: hs@denx.de
> Cc: linuxppc-embedded@ozlabs.org; Chad.Rowan@thyssenkrupp.com
> Subject: Re: export-objs in spi Makefile broke in latest  
> linuxppc_2_4_deve l
> [r eposted]?
>
>
> On Jul 19, 2006, at 11:55 PM, Heiko Schocher wrote:
>
>> Hello Chad
>>
>>> linuxppc_2_4_devel is alive and well.
>>>
>>> http://www.denx.de/cgi-bin/gitweb.cgi?
>>> p=linuxppc_2_4_devel.git;a=shortlog
>>
>> You speak from the DENX linuxppc_2_4_devel Kernel? If so, I think
>> you are right.
>> I had the same problem, some days ago. I made a SPI bitbanging
>> algorithm, but
>> I dont know, if this goes in the git repository from DENX ...
>> Wolfgang?
>
> I think this issue should be taken off list.
>
> - k
