Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 36E0467A5C
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 00:06:01 +1000 (EST)
In-Reply-To: <20060425074902.GA20228@gate.ebshome.net>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A64C3686-0123-4750-BA7B-630E8BF2E4D8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 09:05:54 -0500
To: Eugene Surovegin <ebs@ebshome.net>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 2:49 AM, Eugene Surovegin wrote:

> On Tue, Apr 25, 2006 at 01:08:00AM -0500, Kumar Gala wrote:
>>
>> On Apr 24, 2006, at 5:31 PM, Dan Malek wrote:
>>
>>>
>>> On Apr 24, 2006, at 5:43 PM, Kumar Gala wrote:
>>>
>>>> However, I am against removing the arch/ppc support until the u- 
>>>> boot
>>>> patches are picked up.  I think its bad form to give people a  
>>>> kernel
>>>> they can't easily boot.
>>>
>>> What about systems that can't update u-boot, but want to run
>>> a newer kernel?
>>
>> Does this situation exist for any in tree boards that are supported?
>
> Kumar, with all due respect, I don't like this attitude. I can have
> eval board where I don't want to upgrade firmware.
>
> Also, this "let's screw everybody who doesn't have their board support
> in tree" is very counter productive. FYI, almost all my contributed
> kernel work was done on custom hardware, not on reference boards.
>
> It seems some people here lost touch with reality - embedded Linux is
> mostly run on custom hardware, not on evaluation boards.

Well, first all I said was that we shouldn't remove arch/ppc support  
until the u-boot patches are in.  I made no statement about when  
after that we should remove arch/ppc support.

Second, this seems normal like normal kernel development to me.  I  
think its reasonable to pick some time frame after which we will  
remove the support and to let everyone know what that is.  I see this  
as no different than having a driver outside of the kernel tree and  
having it break when APIs change.

- kumar
