Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.12.36.68])
	by ozlabs.org (Postfix) with ESMTP id 270FADDF14
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Jul 2007 19:25:20 +1000 (EST)
Message-ID: <468A15D9.7010003@semihalf.com>
Date: Tue, 03 Jul 2007 11:24:41 +0200
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PCI IO range limitation
References: <46838B54.2010806@semihalf.com>
	<1183052634.5521.284.camel@localhost.localdomain>
In-Reply-To: <1183052634.5521.284.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-2
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
> On Thu, 2007-06-28 at 12:20 +0200, Marian Balakowicz wrote:
>> I guess that with the above dropping of non-zero based PCI IO ranges
>> this is not supposed to be working. But does anyone know why?
> 
> We just fixed that for 64 bits but 32 bits still has the limitation.
> Note that it's not a very good idea to have your IO range at !0 if
> you're going to use anything ISA-like, such as a VGA video card or other
> legacy devices behind a PCI southbridge or SuperIO.

Agree with the zero-based IO range for ISA devices. But, knowing we don't have any ISA stuff on board it should be possible to change the IO base. Are you planning on modifications for 32 bits as well?

Marian
