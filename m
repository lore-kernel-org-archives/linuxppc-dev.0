Return-Path: <matt@genesi-usa.com>
Received: from mail.genesi-usa.com (mithrandir.softwarenexus.net
	[66.98.186.96])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 67A9DDDF0F
	for <linuxppc-dev@ozlabs.org>; Sat, 30 Jun 2007 03:08:13 +1000 (EST)
Message-ID: <46853CA2.2040203@genesi-usa.com>
Date: Fri, 29 Jun 2007 18:08:50 +0100
From: Matt Sealey <matt@genesi-usa.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI IO range limitation
References: <46838B54.2010806@semihalf.com>	
	<1183052634.5521.284.camel@localhost.localdomain>	
	<46844692.1040804@genesi-usa.com>
	<1183075997.5521.292.camel@localhost.localdomain>
In-Reply-To: <1183075997.5521.292.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org, Marian Balakowicz <m8@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:

> On Fri, 2007-06-29 at 00:38 +0100, Matt Sealey wrote:
>> Benjamin Herrenschmidt wrote:
>>> On Thu, 2007-06-28 at 12:20 +0200, Marian Balakowicz wrote:
>>>> Hi,
>>>>
>>>> Trying to change PCI IO window base for 52xx target I found that
>>>> we are pretty much limited to a "0" offset only.
>>> We just fixed that for 64 bits but 32 bits still has the limitation.
>>> Note that it's not a very good idea to have your IO range at !0 if
>>> you're going to use anything ISA-like, such as a VGA video card or other
>>> legacy devices behind a PCI southbridge or SuperIO.
>> The chances of that on an MPC52xx platform are practically zero, aren't
>> they?
> 
> Euh... don't you use VGA video cards on Efika ? :-)

Define "legacy device"? What should that entail? You mean like mapping
most of those registers to the first couple of kilobytes of "IO"?

If they're just left as their own on their own as PCI devices, why would
it matter what the window was?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
