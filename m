Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 23339DDF70
	for <linuxppc-dev@ozlabs.org>; Wed, 24 Oct 2007 03:19:31 +1000 (EST)
Message-ID: <471E2CDA.1080301@ru.mvista.com>
Date: Tue, 23 Oct 2007 21:18:18 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC 440EPx Sequoia USB OHCI DTS entry
References: <20071008142658.GA15197@ru.mvista.com>
	<e1b19c12c7006e763a56627fa9a05ec9@kernel.crashing.org>
In-Reply-To: <e1b19c12c7006e763a56627fa9a05ec9@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>> +            compatible = "ohci-be";
> 
> Can we fix this please, in the same way as with EHCI?  I.e., the
> "compatible" should say it is USB, e.g. "usb-ohci"; and the
> "big-endian" quirkiness should be expressed by a property, not by
> the "compatible" name (since that would lead to exponential
> explosion of all possible combinations of quirks, if nothing else).
> 
> 
> Segher
> 
I was thinking about it too.
We need to fix the OHCI OF driver and all its users' dts files (if any).
Actually I also don't see much reason for the 
USB_OHCI_HCD_PPC_OF_BE/USB_OHCI_HCD_PPC_OF_LE stuff.
Is this really needed?
Thanks,
Valentine.
