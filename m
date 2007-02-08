Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 341F0DDFC9
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 04:19:51 +1100 (EST)
In-Reply-To: <32F3CC26D4DAC44E8ECD07155727A46E8B7E7E@zch01exm20.fsl.freescale.net>
References: <32F3CC26D4DAC44E8ECD07155727A46E8B7E7E@zch01exm20.fsl.freescale.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <33A3AF2F-7238-4D00-9B3F-9F7D451DF7C9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [patch][0/5] powerpc V2 : Add support to fully comply with
	IEEE-754 standard
Date: Thu, 8 Feb 2007 11:18:57 -0600
To: Zhu Ebony-r57400 <ebony.zhu@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Feb 8, 2007, at 2:08 AM, Zhu Ebony-r57400 wrote:

>>>>
>>>> Did you end up getting testfloat running?  I'd like to see some
>>>> testing results before accepting these patches.  I think
>> testfloat is
>>>> our best bet at this point.
>>>>
>>> Hi Kumar,
>>>
>>> I looked into the testfloat suit, and found all the instructions it
>>> tests (more than 50)should be implemented based on ASM.
>>
>> Don't follow?  Can't you build it with the e500 compiler?
>>
> The TestFloat suite provided the target of 386-Win32-gcc and
> SPARC-Solaris-gcc only, and a template for user to porting his
> own processor. Some general instructions are implemented in C,
> but some CPU specific instructions like evfsmul need to be
> implemented assemblely. To build it with e500 compiler we still
> Have some porting work to do.

I wouldn't worry too much about the vector forms.  If the scalar  
single fp and double fp test out ok the vectors are pretty much  
similar enough.

Lets just get the scalar versions tested and work out any issues there.

- k
