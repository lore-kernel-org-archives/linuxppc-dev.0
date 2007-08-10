Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 6D656DDDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 11 Aug 2007 00:35:53 +1000 (EST)
In-Reply-To: <fa686aa40708091154t55ca4df7q7be2acf5662e6076@mail.gmail.com>
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>
	<200708070124.04748.arnd@arndb.de>
	<fa686aa40708091154t55ca4df7q7be2acf5662e6076@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <004650C7-11FB-4A77-A797-148A7FDBD29D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
Date: Fri, 10 Aug 2007 09:37:09 -0500
To: Grant Likely <grant.likely@secretlab.ca>
Cc: Arnd Bergmann <arnd@arndb.de>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Aug 9, 2007, at 1:54 PM, Grant Likely wrote:

> On 8/6/07, Arnd Bergmann <arnd@arndb.de> wrote:
>> On Tuesday 07 August 2007, Wolfgang Reissnegger wrote:
>>>
>>> Make support for Xilinx boards more generic, making it easier
>>> to add new boards. Add initial support for xupv2p and ml410 boards.
>>
>> I really think we shouldn't add stuff to arch/ppc at this point,
>> it has been deprecated for over two years now.
>
> Naahh, this is pretty benign stuff.  I say let it go in.  :-)
>
> These changes are low risk and they don't hurt anything.  If Virtex
> support worked in arch/powerpc then I'd agree, but for now it allows
> us to keep the virtex device driver support somewhat current.

We've clearly stated for a while that only bug fixes should be going  
into arch/ppc.  This looks like new board support.

Also, be aware that arch/ppc is going away in Jun 2008. :)

- k
