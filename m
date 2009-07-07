Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 29513B6F1F
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  8 Jul 2009 02:05:09 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 82182DDD0C
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Jul 2009 02:05:08 +1000 (EST)
Message-Id: <F31BA364-BDFA-41C4-9A6D-8BCD20F97E54@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: =?ISO-8859-1?Q?K=E1ri_Dav=ED=F0sson?= <kari.davidsson@marel.com>
In-Reply-To: <4A5368C7.9020202@marel.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v935.3)
Subject: Re: dma_ops->map_page == NULL
Date: Tue, 7 Jul 2009 10:45:22 -0500
References: <4A523984.2080904@marel.com> <200907071015.24097.markn@au1.ibm.com>
	<1246964905.6066.41.camel@pasglop>
	<A0ABEB1B-3A7A-4068-88EC-33D6D663C87A@kernel.crashing.org>
	<4A5368C7.9020202@marel.com>
Cc: Mark Nelson <markn@au1.ibm.com>,
	"linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
	Kumar Gala <galak@gate.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 7, 2009, at 10:24 AM, K=E1ri Dav=ED=F0sson wrote:

> Yes the device pointer was invalid.
>
> I was passing the of_device pointer instead of
> the address of of_device->dev.
>
> But I am sure this was working (passing of_device pointer) with
> earlier kernels.
>
> Thanks for the help.
>
> rg
> kd

earlier kernels didn't care if the dev pointer was valid and thus let =20=

it pass if you didn't give the proper thing.

- k=
