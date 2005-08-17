Return-Path: <kumar.gala@freescale.com>
In-Reply-To: <1124209292.3869.5.camel@localhost.localdomain>
References: <1124209292.3869.5.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v733)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <11F30454-6808-44A3-8F5B-F36ED0028EF4@freescale.com>
From: Kumar Gala <kumar.gala@freescale.com>
Date: Wed, 17 Aug 2005 01:30:58 -0500
To: David Woodhouse <dwmw2@infradead.org>
Cc: linuxppc-embedded list <linuxppc-embedded@ozlabs.org>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Subject: Re: [PATCH] Use platform device for 8250 registration
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 16, 2005, at 11:21 AM, David Woodhouse wrote:

> My dual G4 PowerMac crashes sometimes when it probes for the (absent)
> serial ports. Theoretically it's supposed to take a machine check and
> recover -- but it doesn't always work like that.
>
> This patch removes the defaults from asm/pc_serial.h and uses the code
> which already existed for ppc64 to register any ports which are  
> found in
> the device tree. It's slightly updated to work in 32-bit and also  
> on the
> Pegasos which claims the input frequency is 0Hz.
>
> We could probably remove all the rest of the crap from asm/serial.h  
> and
> let platforms register their own serial8250 platform devices. And this
> probably breaks serial ports on PReP, which needs to do likewise.

Hmm, I wondering if we can provide some standard way of handling this  
for the embedded platforms as well.  It would be nice to drop the old  
style of initialization completely and move to using a platform  
device always.

- kumar
