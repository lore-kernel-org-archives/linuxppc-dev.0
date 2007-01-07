Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 201ACDDE25
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 09:39:07 +1100 (EST)
Message-ID: <45A17685.2080204@genesi-usa.com>
Date: Sun, 07 Jan 2007 22:39:01 +0000
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
References: <17799.34168.811328.653008@cargo.ozlabs.ibm.com>	
	<1166528379.19254.69.camel@localhost.localdomain>	
	<4587D338.7060906@246tNt.com>	
	<1166538553.25827.99.camel@pmac.infradead.org>	
	<1166558300.19254.71.camel@localhost.localdomain>	
	<1167773388.22068.443.camel@pmac.infradead.org>	
	<1167773863.6165.82.camel@localhost.localdomain>	
	<1167775493.3660.23.camel@shinybook.infradead.org>	
	<528646bc0701021504k88682bl765fad4c100bd40e@mail.gmail.com>	
	<45A01416.6080401@genesi-usa.com>
	<528646bc0701061423o270df3dfj9d27d5572840ec79@mail.gmail.com>
	<45A1535C.1080007@genesi-usa.com>
	<f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
In-Reply-To: <f0c5df8b1d2bcc1abcd04894e0210cc1@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: David Woodhouse <dwmw2@infradead.org>, bbrv@genesi-usa.com,
	Paul Mackerras <paulus@samba.org>, Linux PPC DEV <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Segher Boessenkool wrote:
>> (especially a C-based one, OpenBIOS
>> is 90% Forth which is a terrible lock-in)

^^^^^^^

> Only 7 days into the new year, and already we get some great
> entries for best-joke-of-2007!  Too bad they're factually
> incorrect.

I'll correct that then, FirmWorks (as used on OLPC) is 90% Forth, and
I think there is a shortage of Forth coders compared to driver-writing
low-level firmware coders who can do C or C++ or any other language
for that matter, I think it makes it commercially unusable if you want
any kind of turnaround on device support.

OpenBIOS is maybe 30% Forth supplementing a fairly C-based implementation
but it is still too much Forth. It also relies on a boot loading stage
previous to it (no abstraction!) like UBoot or a PC BIOS to start with,
so commercially without some work, it's fairly useless.

Either way, without talking about CodeGen's source release (not
commercially usable, and debatably not GPL-compatible either) we're
the only company doing Open Firmware for PowerPC devices, with the
turnaround time we have (talk to Marvell if you like) and offering
the kind of feature support (x86 emulator) we plant on top on request
(Linux BSP including working 3D drivers just to prove the firmware
works and the emulator is setting up any card they desire correctly).

Maybe IBM's PAPR firmware will be great when it arrives sometime in
2008, and put us out of business, but until then I stand by that :D

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
