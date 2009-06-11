Return-Path: <glikely@secretlab.ca>
Received: from yw-out-1718.google.com (yw-out-1718.google.com [74.125.46.155])
	by bilbo.ozlabs.org (Postfix) with ESMTP id A5798B7156
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Jun 2009 02:18:49 +1000 (EST)
Received: by yw-out-1718.google.com with SMTP id 5so843556ywm.32
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 11 Jun 2009 09:18:47 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <C10D11C8340AFC47891731EA67CD31C20162F071EFC7@stwex.stww2k.local>
References: <C10D11C8340AFC47891731EA67CD31C20162F071EFC7@stwex.stww2k.local>
From: Grant Likely <grant.likely@secretlab.ca>
Date: Thu, 11 Jun 2009 10:18:27 -0600
Message-ID: <fa686aa40906110918g2999beb0w2c0d1c9f2ab6d80c@mail.gmail.com>
Subject: Re: MPC5200B: Can't receive/handle external Interrupts
To: Schaller Stephan <Stephan.Schaller@sensor-technik.de>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2009 at 12:03 PM, Schaller
Stephan<Stephan.Schaller@sensor-technik.de> wrote:
> So, basically two Problems:
> - ISR seems only to get called by a "Main Interrupt", not by a "IRQ Interrupt". How do I make the connection between these?

This is probably due to the way the IRQ driver reads the irq registers
to decide what interrupts are pending.  I wouldn't worry about it.

> - The IRQ3 input Pin level is not shown in the status register and is not regognized by the CPU.

Odd.  This shouldn't happen.  Is your hardware okay?

g.

-- 
Grant Likely, B.Sc., P.Eng.
Secret Lab Technologies Ltd.
