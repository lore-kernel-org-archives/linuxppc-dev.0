Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 62239679E9
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 02:26:11 +1000 (EST)
In-Reply-To: <20060425161200.GC20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<A64C3686-0123-4750-BA7B-630E8BF2E4D8@kernel.crashing.org>
	<20060425161200.GC20228@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <6F7CAB43-B4C0-47DA-BC7D-3FD04A552131@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 11:25:59 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 11:12 AM, Eugene Surovegin wrote:

> On Tue, Apr 25, 2006 at 09:05:54AM -0500, Kumar Gala wrote:
>>
>> Second, this seems normal like normal kernel development to me.  I
>> think its reasonable to pick some time frame after which we will
>> remove the support and to let everyone know what that is.  I see this
>> as no different than having a driver outside of the kernel tree and
>> having it break when APIs change.
>
> I don't agree. This is not the same as changing _internal_ kernel API
> for a simple reason that _firmware_ was never part of the kernel and
> will never be. You seem to have an idea that's that's OK to _remove_
> existing functionality from the kernel for no reason except your
> convenience. I think this is unacceptable. If kernel was able to boot
> on some hardware (including reference one) in the past it should be
> able to do this now even if this will require some boot shim.

If we are talking about a reference board than I think this is an  
absurd requirement.  If you are willing to update your kernel on such  
a board why would you not be willing to update the firmware as well.

To my knowledge all the in tree boards that are supported for 85xx  
all boot via u-boot.  So if u-boot is available for the given board  
that is capable of booting an arch/powerpc kernel why would we need  
to continue supporting the board in arch/ppc.

- kumar 
