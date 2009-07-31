Return-Path: <dgibson@bilbo.ozlabs.org>
Date: Fri, 31 Jul 2009 10:45:24 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] Add support for the ESTeem 195E (PPC405EP) SBC
Message-ID: <20090731004524.GA10243@yookeroo.seuss>
References: <1248448916-29473-1-git-send-email-solomon@linux-wlan.com>
	<20090730140630.GD10244@zod.rchland.ibm.com>
	<20090730194506.GA30066@linux-wlan.com>
	<20090730200848.GF10244@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090730200848.GF10244@zod.rchland.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Solomon Peachy <solomon@linux-wlan.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jul 30, 2009 at 04:08:49PM -0400, Josh Boyer wrote:
> On Thu, Jul 30, 2009 at 03:45:06PM -0400, Solomon Peachy wrote:
> >On Thu, Jul 30, 2009 at 10:06:30AM -0400, Josh Boyer wrote:
[snip]
> >> >+			UART0: serial@ef600400 {
> >> >+				device_type = "serial";
> >> >+				compatible = "ns16550";
> >> >+				reg = <0xef600400 0x00000008>;
> >> >+				virtual-reg = <0xef600400>;
> >> >+				clock-frequency = <0>; /* Filled in by zImage */
> >> >+				current-speed = <0x9600>;
> >> 
> >> Just a question, but is the baud supposed to be 38400 or 9600?  At first glance
> >> it almost seems like a typo :).
> >
> >It's supposed to be 38400 baud, hence the explicit 0x in front.  (I lost 
> >count of the number of times I saw '38400' listed in various dts 
> >files...)
> 
> Cool.  Just checking.

Um.. except, surely it's clearer to just list 38400 in decimal, rather
than 0x9600 which people are very likely to misread as 9600.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
