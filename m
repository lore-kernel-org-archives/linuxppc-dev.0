Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7D7BBDDDE6
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Nov 2007 09:39:20 +1100 (EST)
Subject: Re: mmap on PPC removes file refcount?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dave Jiang <djiang@mvista.com>
In-Reply-To: <474B4923.905@mvista.com>
References: <47435338.2050107@mvista.com>  <474B4923.905@mvista.com>
Content-Type: text/plain
Date: Tue, 27 Nov 2007 09:38:09 +1100
Message-Id: <1196116689.7157.5.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-11-26 at 15:30 -0700, Dave Jiang wrote:
> NM, it was a bad test causing weird behavior on PPC. :(

Ah good, because I did spend some time looking at the code and didn't
see anything wrong :-)

Cheers,
Ben.
