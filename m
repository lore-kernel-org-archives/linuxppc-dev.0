Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 21420B7CED
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Mar 2010 09:57:43 +1100 (EST)
Subject: Re: Continual reading from the PowerPc time base register is not
	stable
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Chris Friesen <cfriesen@nortel.com>
In-Reply-To: <4BABDD16.4080705@nortel.com>
References: <43c137a81003241941p84cba56y3e02e40cb22623e2@mail.gmail.com>
	<1269505301.8599.238.camel@pasglop> <201003251105.10033.arnd@arndb.de>
	<43c137a81003250800n660195c5k42c8516068aeda8d@mail.gmail.com>
	<4BABDD16.4080705@nortel.com>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 26 Mar 2010 09:57:31 +1100
Message-ID: <1269557851.8599.258.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Csdncannon <csdncannon@gmail.com>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-03-25 at 16:00 -0600, Chris Friesen wrote:
> Shouldn't "upper" be cast to 64-bit before shifting?

Yup but that doesn't explain his results. I think Segher nailed it to a
stuck bit tho, so I would blame defective HW or HW used outside of
normal operating conditions (maybe the TB is sourced out of bounds ?)

Cheers,
Ben.
