Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3885568722
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Nov 2005 03:37:33 +1100 (EST)
In-Reply-To: <1131834336.7406.46.camel@gaston>
References: <Pine.LNX.4.64.0511111753080.3263@g5.osdl.org>
	<200511122145.38409.mbuesch@freenet.de>
	<Pine.LNX.4.64.0511121257000.3263@g5.osdl.org>
	<200511122237.17157.mbuesch@freenet.de>
	<1131834336.7406.46.camel@gaston>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <71C11A0C-4FC8-4081-A890-A4FF7DA48752@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Date: Sun, 13 Nov 2005 10:37:44 -0600
To: Paul Mackerras <paulus@samba.org>
Cc: ppc-dev list <linuxppc-dev@ozlabs.org>, Linus Torvalds <torvalds@osdl.org>,
	Michael Buesch <mbuesch@freenet.de>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Linuv 2.6.15-rc1
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Nov 12, 2005, at 4:25 PM, Benjamin Herrenschmidt wrote:

> On Sat, 2005-11-12 at 22:37 +0100, Michael Buesch wrote:
>> On Saturday 12 November 2005 22:00, you wrote:
>>>
>>> On Sat, 12 Nov 2005, Michael Buesch wrote:
>>>>
>>>> Latest GIT tree does not boot on my G4 PowerBook.
>>>
>>> What happens if you do
>>>
>>> 	make ARCH=powerpc
>>>
>>> and build everything that way (including the "config" phase)?
>>
>> I did
>> make mrproper
>> copy the .config over again
>> make ARCH=powerpc menuconfig
>> exit and save from menuconfig
>> make ARCH=powerpc
>
> You need to disable PREP support when building with ARCH=powerpc  
> for 32
> bits, it doesn't build (yet). We should remove it from Kconfig...
>
> Also, there is an issue with the make clean stuff, make sure when
> switching archs to also remove arch/powerpc/include/asm symlink before
> trying to build.

Can we please add some defconfigs for arch/powerpc to possibly help  
with this issue.  I'm think a pmac32, pmac64, and whatever other 64  
bit configs would be a good start.

- kumar
