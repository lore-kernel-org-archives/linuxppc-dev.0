Subject: Re: MPC8560ADS issues
From: "Matthew S. McClintock" <mattsm@arlut.utexas.edu>
To: Jason McMullan <jason.mcmullan@timesys.com>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <1078945499.3748.4.camel@veena.timesys>
References: <1078945499.3748.4.camel@veena.timesys>
Content-Type: text/plain
Message-Id: <1079019785.29565.36.camel@chuck.arlut.utexas.edu>
Mime-Version: 1.0
Date: Thu, 11 Mar 2004 09:43:05 -0600
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2004-03-10 at 13:04, Jason McMullan wrote:
> I'm trying to work with FCCs on my PowerQuick III with a
> MPC8560 Rev 1, and I'm having quite a difficult time attempting
> to get the FCC ethernet ports to work.
>

What version of u-boot are you using? There was a patch around Feb. 24th
that fixed some things in the ethernet driver for u-boot. Although since
you seem to have the TSEC ports working it seems you have the latest
version.

> The GigE (TSEC) ports work just fine, but the FCC ports don't seem
> to TX or RX anything. No IRQs from the FCC, but I get IRQs from the
> PHYs

U-boot does not use interrupts for networking, it just uses polling. How
are you determining you are seeing interrupts from the PHYs and not the
FCC?


>   Has anyone had any success with the MPC8560ADS and FCCs? In either
> Linux or u-boot?

I have not attempted to use the FCC in u-boot but I have it working in
Linux, well sort of anyways... it is going extremely slow and I am still
investigating that. That being said I don't think u-boot has support for
using the FCC, so what changes did you make to get u-boot?



--
Matthew S. McClintock <mattsm@arlut.utexas.edu>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
