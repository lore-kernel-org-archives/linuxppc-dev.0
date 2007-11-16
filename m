Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 3611EDDE09
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 17 Nov 2007 08:14:58 +1100 (EST)
Message-ID: <473E084B.4080703@anagramm.de>
Date: Fri, 16 Nov 2007 22:14:51 +0100
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: Latest paulus.git PCI broken on mpc8540?
References: <473C7FCC.7050307@anagramm.de>	
	<4E0EFED3-8697-4768-9D89-A2443AEC82A5@kernel.crashing.org>	
	<1195191333.28865.140.camel@pasglop>	
	<A4E1A594-5A31-4EFE-B4F9-E4B24F9207F7@kernel.crashing.org>
	<1195247357.28865.178.camel@pasglop>
In-Reply-To: <1195247357.28865.178.camel@pasglop>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Hi, Ben!

Benjamin Herrenschmidt schrieb:
> On Fri, 2007-11-16 at 13:18 -0600, Kumar Gala wrote:
>>
>> Well, for one the generic pci code will complain if its not able to  
>> allocate the resource which is the true failure.
>>
>> I'm thinking maybe we just make these pr_debug() instead of standard  
>> printk?
> 
> I was thinking about changing the message to "cannot allocate initial
> resource, will reallocate" or something like that. That is, make it
> clear it's non fatal.

I don't know much of the code, so, propably a stupid question:
Can we avoid to do the initial resource allocation, when it's known to fail?

It seems to me like things are done twice here:
1. try
2. reallocate
3. retry

Regards,

-- 
Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm-technology.com
Phone: +49-89-741518-50
Fax: +49-89-741518-19
