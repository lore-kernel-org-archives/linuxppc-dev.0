Return-Path: <rmcguire@uwbt.com>
Received: from mail19d.g19.rapidsite.net (mail19d.dulles19-verio.com
	[204.202.242.120]) by ozlabs.org (Postfix) with SMTP id DD39D679F4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Mar 2006 02:54:33 +1100 (EST)
From: "Russell McGuire" <rmcguire@uwbt.com>
To: "'Dan Malek'" <dan@embeddedalley.com>
Subject: RE: GNU and Freescale MPC83xx / e300 core support?
Date: Tue, 7 Mar 2006 07:54:19 -0800
Message-ID: <002b01c641ff$666ccc70$6405a8c0@absolut>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
In-Reply-To: <50206c46cf7e37ede345eebf82ad6fbc@embeddedalley.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Thanks all...

The author of that comment humbly apologizes for his ineptitude on the FPU.

It would appear both cores have the same number of execution units, i.e. 5
So David, I guess in all this the only real difference seems to be the bus
architecture, raw clock speed, and perhaps a few new instructions. I checked
both manuals this morning and they do differ in some small ways.

* 603e, up to 4 instructions in the pipeline, only 3 being complete per
clock
* e300, up to 5 instructions in the pipeline, still only 3 being completed
or start per clock.
* Add/compare instructions are now executed in the IU unit instead of the
load/store unit. May be the same, but wasn't specific in earlier 603e
manuals.
* One more HID0 bit than G2, ability to interrupt based on cache parity
error
* new icbt instruction, instruction cache initialization

So there is a section inside the 8360E manual that outlines the specific
enhancements. "Features specific to the e300 core not present on the G2
processors follow:" Page  1-5.

So I guess my question is back up, does anyone know if an optimized compiler
would offer any noticeable performance enhancements in regards to these
changes? Other than the obvious instruction being added?

Thanks

-Russ





-----Original Message-----
From: Dan Malek [mailto:dan@embeddedalley.com] 
Sent: Tuesday, March 07, 2006 4:33 AM
To: Russell McGuire
Cc: 'David Hawkins'; linuxppc-embedded@ozlabs.org
Subject: Re: GNU and Freescale MPC83xx / e300 core support?


On Mar 7, 2006, at 12:52 AM, Russell McGuire wrote:

> .....  The most obvious core difference is
> the Floating Point unit; the MPC8280, 603e or G2LE core had no floating
> point ability at all.

I just want to state for archive purposes this simply isn't true.
All of those processors had hardware FPUs.  If you would take
a few seconds and read the product overviews for these parts,
you can make your own informed decision.  The person you
are talking to doesn't seem to have all of the facts in order.


	-- Dan
