Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 06800DDEE6
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Sep 2007 08:37:03 +1000 (EST)
In-Reply-To: <20070913182453.GA26541@ru.mvista.com>
References: <20070913182453.GA26541@ru.mvista.com>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <2c5fb8f063c275286b6b26ca734ed64d@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] PowerPC: usb ehci of_platform bindings for Sequoia 440EPx
Date: Fri, 14 Sep 2007 00:36:53 +0200
To: Valentine Barshak <vbarshak@ru.mvista.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> EHCI OF bindings for PowerPC 440EPx Sequoia.

Those aren't bindings, they are examples.  Bindings are pieces
of documentation that describe what device-specific properties
mean what, what standard properties are required with what
values, etc.

Examples are good to have, of course.

One thing you really need to document is what "ehci-be-desc"
and friends mean.  I can give you one comment already: for
devices that are usually little-endian, but an implementation
implements registers as big-endian, precedent is to show that
in the device tree by including an (empty) "big-endian" property,
rather than inventing new "compatible" values.


Segher
