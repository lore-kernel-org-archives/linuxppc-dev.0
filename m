Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5F299DE2BF
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 01:05:58 +1000 (EST)
In-Reply-To: <20070716132902.118450@gmx.net>
References: <20070716075317.15260@gmx.net>
	<D0634B84-BD83-460E-AEC2-E8BB2837B237@kernel.crashing.org>
	<20070716132902.118450@gmx.net>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <B7E6FFC1-DD11-45E4-9F4D-ECD786C88023@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: Legacy ISA registers/interrupts in PCI device tree node
Date: Mon, 16 Jul 2007 17:05:49 +0200
To: "Gerhard Pircher" <gerhard_pircher@gmx.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> I wonder, if there is a recommended way to specify ISA register
>>> addresses and interrupts for a PCI device (unlike for a PCI2ISA
>>> bridge)?
>>
>> The PCI binding describes the required way to do this.
> Hmm, I must reread the PCI binding spec. It didn't seem to contain any
> information about this.

You can describe address regions in "reg" that aren't
corresponding to any PCI BAR.  There is also a facility
to describe subtractive decoding (though I don't think
you need this).

>> Yes, it should, even if you don't use this in the Linux
>> kernel yet.
> Well, I still have to wire up the IDE interrupts in the platform setup
> code, right?

Sure, if you want those interrupts to work, anyway ;-)


Segher
