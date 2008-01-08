Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A6125DDFDE
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 09:16:00 +1100 (EST)
Message-ID: <4783F620.8010703@freescale.com>
Date: Tue, 08 Jan 2008 16:16:00 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@jdl.com>
Subject: Re: [PATCH 1/3 v2] Add StorCenter DTS first draft.
References: <E1JCMb2-0002mG-LK@jdl.com>
	<20080108221139.GA5599@loki.buserror.net>
	<E1JCMha-0002qu-9L@jdl.com>
In-Reply-To: <E1JCMha-0002qu-9L@jdl.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> So, like, the other day Scott Wood mumbled:
>> On Tue, Jan 08, 2008 at 04:06:56PM -0600, Jon Loeliger wrote:
>>> +/ {
>>> +	model = "StorCenter";
>>> +	compatible = "storcenter";
>>> +	#address-cells = <1>;
>>> +	#size-cells = <1>;
>>> +
>>> +        aliases {
>>> +                serial0 = &serial0;
>>> +                serial1 = &serial1;
>>> +                pci0 = &pci0;
>>> +        };
>> These should be tabs, not spaces.  Likewise in some other parts of the file.
>>
>> -Scott
> 
> Shoot me now.

Bullet, camera, or heroin?

-Scott
