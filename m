Date: Thu, 21 Aug 2003 10:49:27 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michel D?nzer <michel@daenzer.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: linuxppc-2.5 fixlets
Message-ID: <20030821174927.GL848@ip68-0-152-218.tc.ph.cox.net>
References: <1061487408.1862.10.camel@thor.holligenstrasse29.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1061487408.1862.10.camel@thor.holligenstrasse29.lan>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, Aug 21, 2003 at 07:36:49PM +0200, Michel D?nzer wrote:

> First of all, export flush_tlb_page, which is needed by ext3 and SCSI
> modules.

Applied.

> Then, thanks to the great new build system, some warnings stood out:
>
> Fix 'comparison is always false due to limited range of data type' in
> net/sched/estimator.c by changing char to signed char.

Send to DaveM (davem at redhat.com).

> Finally, fix
>
> drivers/usb/misc/usbtest.c:438: warning: passing arg 1 of `__swab32s'
> from incompatible pointer type
>
> by using le16_to_cpus instead of le32_to_cpus .

Send to Greg KH (greg at kroah.com)

> PS: I guess Ben's PM fixes haven't made it into linuxppc-2.5 yet? The
> display is garbled after sleep.

linuxppc-2.5-benh tree, I suspect.

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
