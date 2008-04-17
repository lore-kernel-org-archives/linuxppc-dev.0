Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7B59FDE221
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:04:57 +1000 (EST)
Message-Id: <CA101A3F-B67C-431F-99B9-DE4F6155A4EE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
In-Reply-To: <20080417150320.GB22368@ld0162-tx32.am.freescale.net>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] fsl: Convert dts to v1 syntax
Date: Thu, 17 Apr 2008 10:04:48 -0500
References: <Pine.LNX.4.64.0804170946470.18068@blarg.am.freescale.net>
	<20080417150320.GB22368@ld0162-tx32.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 17, 2008, at 10:03 AM, Scott Wood wrote:
> On Thu, Apr 17, 2008 at 09:47:24AM -0500, Kumar Gala wrote:
>> 		ranges = <
>> -			0 0 fc000000 04000000
>> -			3 0 fa000000 01000000
>> +			0x0 0x0 0xfc000000 0x4000000
>> +			0x3 0x0 0xfa000000 0x1000000
>
> Chip selects should probably be decimal.

my script isn't that smart :)

patches are welcome for such clean ups.  I made sure the  
resulting .dtb where identical.

- k
