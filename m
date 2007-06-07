Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id E99A4DDF5B
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 03:05:40 +1000 (EST)
In-Reply-To: <1181235084.5674.190.camel@rhino>
References: <1181147415.5674.108.camel@rhino>
	<200706070039.51541.arnd@arndb.de>
	<1181232276.5674.146.camel@rhino>
	<63ff9dee6b212cc7908c8e1b73920ea6@kernel.crashing.org>
	<1181235084.5674.190.camel@rhino>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <7d34ab79d774659a73db117366c4b73d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix the LPC47M192 SuperIO on the MPC8641 HPCN
Date: Thu, 7 Jun 2007 19:05:34 +0200
To: Wade Farnsworth <wfarnsworth@mvista.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> I'd just hide it all, do this setup in the firmware,
>> where it belongs, and don't expose the superio config
>> in the device tree.
>
> That's a valid point.  This probably could (should?) be handled by
> U-boot.

Yeah.  One more argument for this is that _every_
possible OS would need this code executed before
it runs.


Segher
