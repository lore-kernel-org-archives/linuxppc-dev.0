Return-Path: <dan@embeddededge.com>
Received: from penguin.netx4.com (embeddededge.com [209.113.146.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id ABE7967AAA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 28 Jan 2005 13:40:52 +1100 (EST)
In-Reply-To: <313680C9A886D511A06000204840E1CF0A6475BC@whq-msgusr-02.pit.comms.marconi.com>
References: <313680C9A886D511A06000204840E1CF0A6475BC@whq-msgusr-02.pit.comms.marconi.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ff162fe76dfe4457c54b859b9a3e2e84@embeddededge.com>
From: Dan Malek <dan@embeddededge.com>
Date: Thu, 27 Jan 2005 18:37:33 -0800
To: "Povolotsky, Alexander" <Alexander.Povolotsky@marconi.com>
Cc: "'linuxppc-dev@lists.linuxppc.org'" <linuxppc-dev@lists.linuxppc.org>,
	"'linuxppc-embedded@ozlabs.org'" <linuxppc-embedded@ozlabs.org>
Subject: Re: console_init() question 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Jan 27, 2005, at 6:07 PM, Povolotsky, Alexander wrote:

> I can not find (so far ) any specific error in values supplied vi 
> bd_info
> from the ("custom" modified pSOS bootloader) causing above problem.

Do you boot over a network?  Does your boot loader shut down
the network controller and interrupts before jumping to the kernel?

Everything looks OK until the CPM and serial port are reconfigured
by Linux, so something is amiss with that.  Could be many reasons
such as location of BDs and buffers, some part of the CPM still
running a peripheral from the boot loader that Linux doesn't know
about, and so on.

	-- Dan
