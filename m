Return-Path: <linuxppcemb@lkmail.de>
Received: from pm1.terions.de (pm1.terions.de [83.137.96.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "*.s-s-l.net",
	Issuer "Equifax Secure Global eBusiness CA-1" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EA935DDF37
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 25 Apr 2007 01:15:08 +1000 (EST)
From: "Lorenz Kolb" <linuxppcemb@lkmail.de>
To: <linuxppc-embedded@ozlabs.org>
References: <mailman.1028.1177426735.26657.linuxppc-embedded@ozlabs.org>
In-Reply-To: <mailman.1028.1177426735.26657.linuxppc-embedded@ozlabs.org>
Subject: Re: Using Xilinx Framebuffer on ML405 and 2.6.20.4
Date: Tue, 24 Apr 2007 17:07:57 +0200
Message-ID: <000001c78682$5e6a3e40$1b3ebac0$@de>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> Message: 1
> Date: Tue, 24 Apr 2007 17:58:13 +0400
> From: Andrei Konovalov <akonovalov@ru.mvista.com>
> Subject: Re: Using Xilinx Framebuffer on ML405 and 2.6.20.4
> To: Grant Likely <grant.likely@secretlab.ca>
> Cc: linuxppc-embedded@ozlabs.org
> Message-ID: <462E0CF5.4060402@ru.mvista.com>
> Content-Type: text/plain; charset=ISO-8859-1; format=flowed
>
> Grant Likely wrote:
>> On 4/24/07, Peter Mendham <petermendham@computing.dundee.ac.uk> wrote:
>>> Dear all,
>>>
>>> I am wanting to use the Xilinx TFT controller from the ML403/5 reference
>>> project (probably from ML300 as well) under a 2.6.20.4 kernel.  I have
>>> Grant Likely's patchset applied in which there is a platform device
>>> entry for the framebuffer.  Does anyone know if there is mainline
>>> support for the Xilinx-style framebuffer?  If so, how do I enable it?  I
>>> have included framebuffer support in my kernel build, but I assume I
>>> need a driver also? Any tips greatly appreciated.
>> 
>> Heh, I've got a driver.  I just haven't published it yet.  Give me a few
days...
>> 
>> g.
>> 
>
> We have one too :)

To be continued: we have one too :)
I guess fb support is too simple, as too many people have wrote that driver
...

Greetings,

Lorenz
