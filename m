Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 47F71DDE2C
	for <linuxppc-dev@ozlabs.org>; Fri, 25 Jan 2008 02:07:40 +1100 (EST)
Message-ID: <4798A95B.50304@freescale.com>
Date: Thu, 24 Jan 2008 09:06:03 -0600
From: Jon Loeliger <jdl@freescale.com>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 3/4 v4] POWERPC: Add initial iomega StorCenter board port.
References: <E1JHkYk-00010g-M2@jdl.com>
	<20080124115018.69551acf.sfr@canb.auug.org.au>
In-Reply-To: <20080124115018.69551acf.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> Hi Jon,

>> +
>> +	dnp = of_find_node_by_type(NULL, "open-pic");
>> +	if (dnp == NULL)
>> +		return;
>> +
>> +	prop = of_get_property(dnp, "reg", &size);
>> +	if (prop == NULL)
>> +		return;
> 
> You need an of_node_put(dnp) before you return.

"Damn your eyes!"

Kumar, I'll send you a patch here...

jdl
