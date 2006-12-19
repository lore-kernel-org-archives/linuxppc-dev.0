Return-Path: <tnt@246tNt.com>
Received: from outmx012.isp.belgacom.be (outmx012.isp.belgacom.be
	[195.238.5.70])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9AC82DDF93
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Dec 2006 09:34:41 +1100 (EST)
Received: from outmx012.isp.belgacom.be (localhost [127.0.0.1])
	by outmx012.isp.belgacom.be (8.12.11.20060308/8.12.11/Skynet-OUT-2.22)
	with ESMTP id kBJMYRNq031504
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Dec 2006 23:34:31 +0100
	(envelope-from <tnt@246tNt.com>)
Message-ID: <458868A3.8090403@246tNt.com>
Date: Tue, 19 Dec 2006 23:33:07 +0100
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	
	<1166522096.25827.76.camel@pmac.infradead.org>	
	<1166528379.19254.69.camel@localhost.localdomain>	
	<4587D338.7060906@246tNt.com>	
	<1166538553.25827.99.camel@pmac.infradead.org>
	<1166558300.19254.71.camel@localhost.localdomain>
In-Reply-To: <1166558300.19254.71.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, bbrv@genesi-usa.com,
	David Woodhouse <dwmw2@infradead.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> OK, let's drop the patch and assume the device-tree will be fixed
>> shortly. 
>>     
>
> No, keep the patch for now. I'm afraid they aren't willing to fix their
> device-tree.
>   
Ok,
but please, put a comment near it would be nice if we remember why we
put it there.


Sylvain
>   
>> In the meantime, users should be able to work around it by
>> hacking the device-tree from the OF prompt -- which we currently have to
>> do for other things in the Efika device-tree anyway.
>>
>> I'm happy enough for Fedora to require the fixed firmware, certainly. 
>>
>>     
>
>   
