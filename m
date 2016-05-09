Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r3cc241QNzDq7j
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 May 2016 08:33:38 +1000 (AEST)
Message-ID: <1462833187.20290.123.camel@kernel.crashing.org>
Subject: Re: usb: dwc2: regression on MyBook Live Duo / Canyonlands since
 4.3.0-rc4
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Felipe Balbi <felipe.balbi@linux.intel.com>, Arnd Bergmann
 <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, linux-mips@linux-mips.org
Cc: a.seppala@gmail.com, johnyoun@synopsys.com, gregkh@linuxfoundation.org,
 linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org, Christian
 Lamparter <chunkeey@googlemail.com>
Date: Tue, 10 May 2016 08:33:07 +1000
In-Reply-To: <8737prikg9.fsf@intel.com>
References: <4231696.iL6nGs74X8@debian64> <1908894.Nkk1LXQkFm@debian64>
 <1462753402.20290.95.camel@au1.ibm.com> <4162108.qmr2GZCaDN@wuerfel>
 <8737prikg9.fsf@intel.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-05-09 at 13:39 +0300, Felipe Balbi wrote:
> and patch all drivers similarly? Shouldn't arch/mips itself deal with
> it and hide it from drivers ?

Not sure what you mean, but we never had "endian neutral" accessors. It
would be a bit of an endeavour and we already have so many accessors
that adding more need a very strong justification.

Most IP blocks have a fixed endian...

Ben.
