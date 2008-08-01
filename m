Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 65C60DDEEF
	for <linuxppc-dev@ozlabs.org>; Fri,  1 Aug 2008 22:47:01 +1000 (EST)
Message-Id: <48592693-41C0-4A71-8678-A0F44457BE47@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Ben Dooks <ben-linux@fluff.org>
In-Reply-To: <20080801104347.GM26938@trinity.fluff.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: libata badness
Date: Fri, 1 Aug 2008 07:46:50 -0500
References: <95646AC3-5385-4F59-8EBA-20F811168A87@kernel.crashing.org>
	<20080731210410.GA623@polina.dev.rtsoft.ru>
	<DAE7C7B4-CE5B-45EB-B3B4-E5491A843CD9@kernel.crashing.org>
	<20080801104347.GM26938@trinity.fluff.org>
Cc: linux-ide@vger.kernel.org, Jeff Garzik <jgarzik@pobox.com>,
	Linux Kernel list <linux-kernel@vger.kernel.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 1, 2008, at 5:43 AM, Ben Dooks wrote:

> On Thu, Jul 31, 2008 at 04:58:05PM -0500, Kumar Gala wrote:
>> I figured out the issue.  Its related to the interrupt routing being
>> conveyed to the code from the device tree.  We have a missing 'space'
>> causing issues.
>
> out of interest, is the M5229 attached to a single IRQ in this device
> or has the bridge been configured to route the IRQs from the IDE to
> the same pin on the PIC?

The bridge is routing interrupts via an i8259 to a single interrupt on  
the OpenPIC (primary pic).

- k
