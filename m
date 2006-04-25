Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4197867A2E
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Apr 2006 16:08:08 +1000 (EST)
In-Reply-To: <17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
References: <1145900516.4251.18.camel@cashmere.sps.mot.com>
	<4C61B597-BD91-4D05-BB40-43DE0319F123@kernel.crashing.org>
	<17017F03-078C-4B7F-A961-EC371F534E27@embeddedalley.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <34C11E8A-ED04-490F-B601-841DC1F94AD6@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: 85xx FDT updates?
Date: Tue, 25 Apr 2006 01:08:00 -0500
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


On Apr 24, 2006, at 5:31 PM, Dan Malek wrote:

>
> On Apr 24, 2006, at 5:43 PM, Kumar Gala wrote:
>
>> However, I am against removing the arch/ppc support until the u-boot
>> patches are picked up.  I think its bad form to give people a kernel
>> they can't easily boot.
>
> What about systems that can't update u-boot, but want to run
> a newer kernel?

Does this situation exist for any in tree boards that are supported?

- kumar
