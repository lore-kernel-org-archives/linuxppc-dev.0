Return-Path: <m8@semihalf.com>
Received: from mail.semihalf.com (mail.semihalf.com [83.15.139.206])
	by ozlabs.org (Postfix) with ESMTP id 2E720DDE42
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Nov 2007 01:16:04 +1100 (EST)
Message-ID: <47346B98.2080003@semihalf.com>
Date: Fri, 09 Nov 2007 15:15:52 +0100
From: Marian Balakowicz <m8@semihalf.com>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH v3 07/13] [POWERPC] TQM5200 DTS
References: <20071106200446.10913.29338.stgit@hekate.izotz.org>
	<20071106200548.10913.42168.stgit@hekate.izotz.org>
	<20071106223646.GD31367@localhost.localdomain>
In-Reply-To: <20071106223646.GD31367@localhost.localdomain>
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

David Gibson wrote:
> On Tue, Nov 06, 2007 at 09:05:48PM +0100, Marian Balakowicz wrote:
>> Add device tree source file for TQM5200 board.
 > [snip]
>> +		usb@1000 {
>> +			device_type = "usb-ohci-be";
> 
> This device_type is bogus.  Remember having a valid device_type is the
> exception not the rule.  Really the only common device_type values are
> "cpu", "memory", "network" and "serial".

Ok, rechecked this one, doesn't seem necessary, removed.

>> +		serial@2000 {		// PSC1
>> +			device_type = "serial";
>> +			compatible = "mpc5200-psc-uart";
>> +			port-number = <0>;  // Logical port assignment
> 
> I know you said this is still needed, but the driver really needs to
> be fixed.  This is not a proper way of using the device tree for
> logical numbering.

True, driver needs fixing, but there are also other boards that use
that driver, and I am not able to test them right now. And, as I
recall Grant mentioned that he's working on straightening this up.

Cheers,
m.
