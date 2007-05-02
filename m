Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EBE0EDDE45
	for <linuxppc-dev@ozlabs.org>; Wed,  2 May 2007 13:39:17 +1000 (EST)
In-Reply-To: <200704240746.05129.sr@denx.de>
References: <Pine.LNX.4.64.0704191615040.25069@localhost.localdomain>
	<20070424000153.GD23995@crusty.rchland.ibm.com>
	<ada647m635h.fsf@cisco.com> <200704240746.05129.sr@denx.de>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <E98E4E57-2322-412F-A58E-A0CCC39DDCE3@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [RFC/PATCH] Change 440GP platform to ppc440
Date: Tue, 1 May 2007 22:38:29 -0500
To: Stefan Roese <sr@denx.de>
Cc: linuxppc-dev@ozlabs.org, Roland Dreier <rdreier@cisco.com>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 24, 2007, at 12:46 AM, Stefan Roese wrote:

> On Tuesday 24 April 2007 02:12, Roland Dreier wrote:
>>>> I recall dimly that there was some user-visible difference  
>>>> between the
>>>> 440GP and the other 440 processors, and that's why we made the
>>>> platform string different.  I don't recall what the difference was.
>>
>> FWIW, I've run the same userspace (binaries) on 405GPr, 440GP and
>> 440SPe without any problems.  Not that I'm a 4xx expert by any
>> stretch, but I don't know of anything special about the 440GP.
>
> I don't know of any differences either. So I'm voting to change the  
> platform
> to ppc440 too.

After some discussion with Paul we think we figured out why 440GP was  
marked differently.  I doesn't implement 'isel', and all other 440's do.

- k
