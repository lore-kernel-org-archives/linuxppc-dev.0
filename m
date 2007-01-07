Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E67B7DDE30
	for <linuxppc-dev@ozlabs.org>; Mon,  8 Jan 2007 10:28:09 +1100 (EST)
In-Reply-To: <45A17685.2080204@genesi-usa.com>
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
	<45A17685.2080204@genesi-usa.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <1468e0c27dbe0a98b2d0e8e34f95e4e5@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Probe Efika platform before CHRP.
Date: Mon, 8 Jan 2007 00:27:20 +0100
To: Matt Sealey <matt@genesi-usa.com>
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

>>> (especially a C-based one, OpenBIOS
>>> is 90% Forth which is a terrible lock-in)
>
> ^^^^^^^
> I'll correct that then, FirmWorks (as used on OLPC) is 90% Forth,

Much more than 90%, heh.

> and
> I think there is a shortage of Forth coders compared to driver-writing
> low-level firmware coders who can do C or C++ or any other language
> for that matter, I think it makes it commercially unusable if you want
> any kind of turnaround on device support.

> OpenBIOS is maybe 30% Forth supplementing a fairly C-based 
> implementation
> but it is still too much Forth.

I really am not going to argue with you about this; you obviously
have no experience at all with this stuff, what you're saying is
based on preconceptions and nothing more.

> It also relies on a boot loading stage
> previous to it (no abstraction!) like UBoot or a PC BIOS to start with,
> so commercially without some work, it's fairly useless.

It is made to work with LinuxBIOS, instead.  Please research your
statements.

> Either way, without talking about CodeGen's source release (not
> commercially usable, and debatably not GPL-compatible either) we're
> the only company doing Open Firmware for PowerPC devices,

Same comment.

[advertisement snipped here]

It's great you feel so nice about the feature set of your
product, but I fail to see what that has to do with your
attacks on technical sound ways to do technical stuff.


Anyway, let me explain some very basic things.  PowerPC Linux
uses an Open Firmware-style device tree to communicate things
(mostly what hardware is there) from the firmware or the
boot loader to the kernel.  You cannot change this.  If you
really refuse to play within the rules of the game, feel free
to create and maintain your own fork of the kernel tree.


Segher
