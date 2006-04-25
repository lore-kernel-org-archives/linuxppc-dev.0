Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7C55367A39
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Apr 2006 02:55:55 +1000 (EST)
In-Reply-To: <66B13296-80E8-4C9E-803D-F4E3D7AABB25@embeddedalley.com>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
	<34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
	<20060425074902.GA20228@gate.ebshome.net>
	<66B13296-80E8-4C9E-803D-F4E3D7AABB25@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <853005AF-8F43-454D-80E6-F39308F89A47@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 11:55:49 -0500
To: Dan Malek <dan@embeddedalley.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 25, 2006, at 11:49 AM, Dan Malek wrote:

>
> On Apr 25, 2006, at 3:49 AM, Eugene Surovegin wrote:
>
>> It seems some people here lost touch with reality - embedded Linux is
>> mostly run on custom hardware, not on evaluation boards.
>
> This is the reason I usually mention such things.  While we all
> want to see the new features, we have to be sensitive to the
> real world product deployment of Linux.  While your world
> may be a few evaluation boards that allow you to update
> software many times a day, the real world products can't
> afford to do that.  From my own experience, I can tell you
> that none of the deployed systems I've worked on will
> ever update U-Boot.  They consider this a sacred piece of
> software such that is all else fails they can recover a
> system remotely using U-Boot commands.  They won't
> risk updating U-Boot in case it fails.  Making Linux dependent
> on a particular, updated, version of U-Boot just isn't going
> to work in most deployed systems.  Or worse, making
> Linux dependent on U-Boot isn't necessarily popular
> either.  For various reasons, especially when replacing
> legacy software, some custom boot rom is often the
> only choice.

I understand this, however these systems are not in the kernel tree  
and thus we can only do so much for them.  I agree a shim between a  
non-flat dev tree aware u-boot and kernel would be a good thing.   
However, I don't see that as something I have to produce as a board  
maintainer if I can give you and updated u-boot to use.

- kumar
