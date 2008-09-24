Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 41BEDDDEEA
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Sep 2008 05:17:00 +1000 (EST)
Message-ID: <48DA9263.5060103@ru.mvista.com>
Date: Wed, 24 Sep 2008 23:17:55 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: David Brownell <david-b@pacbell.net>
Subject: Re: [PATCH 3/3] USB: driver for Freescale QUICC Engine USB Host
	Controller
References: <20080918151659.GA20140@oksana.dev.rtsoft.ru>
	<20080923225730.GB13617@oksana.dev.rtsoft.ru>
	<48DA1544.5010307@ru.mvista.com>
	<200809241159.04427.david-b@pacbell.net>
In-Reply-To: <200809241159.04427.david-b@pacbell.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: leoli@freescale.com, greg@kroah.com, linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	Andrew Morton <akpm@linux-foundation.org>, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

David Brownell wrote:

>>>>  ... then the root hub emulation is completely pointless.

>>>It isn't. We always should emulate the root hub. The root hub
>>>is part and parcel of any USB Host. Even the one-port one.

>>   Hm, maybe that's what USB core thinks (because UHCI/OHCI/EHCI all 
>>have it) but e.g. MUSB doesn't have the root hub registers...

> Only the OHCI registers have bit positions matching what the USB
> spec says for hub status bits.

    Oh, didn't know that.

> Everything else, including musb_hdrc, has the relevant status encoded in other bits.

    Yes, but I thought that if there are no multiple ports, having the hub is 
just pointless.

>>I looked at the core and figured that USB core seems to use the root hub 
>>interface for port PM, etc. and expects it to bee present, so it seems 
>>unavoidable indeed... :-/

> Or more fundamentally:  for enumeration.  "Unavoidable" is correct.  ;)

    Not sure what you mean here but I guess having a root hub alows an uniform 
model of controlling the ports... anyway, USB specifies that it must be 
present in the host.

WBR, Sergei
