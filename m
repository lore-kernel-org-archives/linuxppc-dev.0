Return-Path: <clemens.koller@anagramm.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.187]) by ozlabs.org (Postfix) with ESMTP id 7B591679F8
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 02:47:01 +1000 (EST)
Message-ID: <428A1F8C.10903@anagramm.de>
Date: Tue, 17 May 2005 18:45:00 +0200
From: Clemens Koller <clemens.koller@anagramm.de>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>,  linuxppc-embedded@ozlabs.org
References: <4289DBE9.9080002@anagramm.de>
	<a659357b80a843e5eb3db2ebd5ec3c53@freescale.com>
In-Reply-To: <a659357b80a843e5eb3db2ebd5ec3c53@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: What ethernet driver to use in 2.6.8.1 instead of gianfar in
 2.6.11.x?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello, Kumar!

 >> for some tests and glibc-builds I want to work with a 2.6.8.1 kernel
 >>  temporarily on a freescale mpc8540.
 >
 > Out of interest, what issues did you have with 2.6.11.x?

I want to see if I can get more details out of failing glibc-2.3.{4,5} ntpl
tests on a running system. That's not related to anything mpc85xx specific.

I'll take the gianfar if necessary.
(Or I just plug a rtl8139 into pci... and go with that)
The .config is not an issue, then. Thanks!

Greets,

Clemens Koller
_______________________________
R&D Imaging Devices
Anagramm GmbH
Rupert-Mayer-Str. 45/1
81379 Muenchen
Germany

http://www.anagramm.de
Phone: +49-89-741518-50
Fax: +49-89-741518-19


Kumar Gala wrote:
>> In 2.6.8.1 there was no gianfar ethernet driver. Is it okay to use the
>>  fec drivers instead of the gianfar or is it better to put the gianfar
>>  drivers back into 2.6.8.1? (100Mbps are okay for that testing)
> 
> 
> I doubt fec drivers would ever work for the TSECs.  You should be able 
> to pull the driver code out of 2.6.11.x for gianfar back into 2.6.8.1 
> w/o any real issue.
> 
>> Maybe somebody can get me a working .config for 2.6.8.1 and mpc8540ads?
> 
> 
> Can you start with the .config file that exists in the 2.6.11 ?
> 
> - kumar
> 
> 
