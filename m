Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 60A8FDDE16
	for <linuxppc-dev@ozlabs.org>; Thu, 25 Oct 2007 21:49:17 +1000 (EST)
Message-ID: <47208273.8050601@ru.mvista.com>
Date: Thu, 25 Oct 2007 15:48:03 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [linux-usb-devel] [PATCH 1/2] USB: Rework OHCI PPC OF for new
	bindings
References: <20071024163412.GA17785@ru.mvista.com>	
	<471FC191.6020704@genesi-usa.com>	
	<200710241850.05467.david-b@pacbell.net>
	<fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>
In-Reply-To: <fa686aa40710241941w16fe3e75hb8ede9f9c8464e94@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: David Brownell <david-b@pacbell.net>, linux-usb-devel@lists.sourceforge.net,
	linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 10/24/07, David Brownell <david-b@pacbell.net> wrote:
>> On Wednesday 24 October 2007, Matt Sealey wrote:
>>> Can we just make sure real quickly that the changing of compatibles
>>> doesn't break existing, not-easily-flashable firmwares?
>> Yeah, I'm not keen on such breakage either...
> 
> Add my voice to the chorus.  It's okay to change the binding, but make
> sure the old binding is still supported.
> 
> Cheers,
> g.
> 

Actually, I thought that changing the DTS stuff for mpc52xx boards would 
suffice. Sorry, I was unaware of Efika firmware here. I'll keep old 
bindings as well.
Does the device tree have "ohci-bigendian" or "ohci-be" compatible 
property on Efika?
Thanks,
Valentine.
