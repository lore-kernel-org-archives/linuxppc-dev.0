Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3BB40DDF13
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Jan 2007 17:38:10 +1100 (EST)
In-Reply-To: <20070130051736.GH28746@smtp.west.cox.net>
References: <20070125073754.GA10004@lixom.net>
	<20070130051736.GH28746@smtp.west.cox.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0747B3CD-F875-4A28-8199-1A7FF3666301@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] generic RTC support for PPC
Date: Tue, 30 Jan 2007 00:37:12 -0600
To: Tom Rini <trini@kernel.crashing.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org, paulus@samba.org,
	kimphill@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 29, 2007, at 11:17 PM, Tom Rini wrote:

> On Thu, Jan 25, 2007 at 01:37:54AM -0600, Olof Johansson wrote:
>
>> Make the PPC RTC functions use the generic RTC infrastructure if they
>> are not already defined (and an RTC is registered in the system).
>>
>> This should make it possible to remove the hideous direct access used
>> in some of the 83xx platforms.
>
> Now, I know I'm a bit late, and I've been quiet of late, but, um,  
> why is
> there anything other than the RTC class stuff being used?  I know
> drivers/char/genrtc.c isn't gone yet, but really, it should be in the
> process of being phased out.  IMHO, it should depend on !POWERPC (or
> whatever the magic is to allow arch/ppc && !arch/powerpc).

I think the problem was calling the RTC class code from the place's  
we use rtc in ppc had locking issues or something like that.

- k
