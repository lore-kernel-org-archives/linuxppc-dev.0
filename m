Return-Path: <akonovalov@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (RT-soft-2.Moscow.itn.ru [80.240.96.70])
	by ozlabs.org (Postfix) with SMTP id 4E14967A2F
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  5 Apr 2005 02:52:28 +1000 (EST)
Message-ID: <42517236.70707@ru.mvista.com>
Date: Mon, 04 Apr 2005 20:58:30 +0400
From: Andrei Konovalov <akonovalov@ru.mvista.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>
References: <20050404164545.E603CC108D@atlas.denx.de>
In-Reply-To: <20050404164545.E603CC108D@atlas.denx.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: Jon Masters <jonathan@jonmasters.org>, Sylvain Munaut <tnt@246tNt.com>,
	Linux PPC Embedded list <linuxppc-embedded@ozlabs.org>,
	Jakob Viketoft <jakob.viketoft@bitsim.se>
Subject: Re: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys
	model...]
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Wolfgang Denk wrote:
> In message <42511D55.4040507@ru.mvista.com> you wrote:
> 
>>Should we rely on U-Boot to give that device tree structure to
>>the kernel? If I got it correct this is how the Freescale team
>>plans to proceed. Jon (Masters), are you going the same way?
> 
> 
> Who said this, and where? I am not aware of such a discussion.

These are just plans:

http://ozlabs.org/pipermail/linuxppc-embedded/2005-April/017561.html

-------- Original Message --------
Subject: Flat OF Device Tree for ppc32 [was: Platform bus/ppc sys model...]
Date: Thu, 31 Mar 2005 09:55:42 -0600
From: Jon Loeliger <jdl@freescale.com>

<snip>
Oh, yeah.  Um, also on my plate will be to construct the
original flat-tree blob in U-Boot to be handed to the kernel.
(I'll start with 85xx and 83xx, naturlich.)
-------- End Original Message --------

Thanks,
Andrei

> Best regards,
> 
> Wolfgang Denk
> 
