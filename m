Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5D3D0DDD0D
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 14 Aug 2007 13:07:59 +1000 (EST)
In-Reply-To: <1187044669.10295.4.camel@server>
References: <1187044669.10295.4.camel@server>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <3FE16C0A-892F-4481-999A-A699C0C70BF9@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] [UPDATED] tsec: Allow Ten Bit Interface to be configurable
Date: Mon, 13 Aug 2007 22:09:37 -0500
To: joe.hamman@embeddedspecialties.com
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 13, 2007, at 5:37 PM, Joe Hamman wrote:

> Allow the address of the Ten Bit Interface (TBI) to be changed in the
> event of a conflict with another device.
>
> Signed-off by: Joe Hamman <joe.hamman@embeddedspecialties.com>
> ---
>
> Please ignore the last patch - I missed a cut & paste error on the  
> range
> that my testing didn't catch.

I think we'd rather this came from the device tree.

- k
