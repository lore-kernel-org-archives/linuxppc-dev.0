Message-ID: <3AC97EED.2389B670@opensource.se>
Date: Tue, 03 Apr 2001 09:42:37 +0200
From: Magnus Damm <damm@opensource.se>
MIME-Version: 1.0
To: Dan Malek <dan@mvista.com>
Cc: Jim Chapman <jim.chapman@bigwig.net>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: MII PHY support?
References: <3AC76542.A4D27697@bigwig.net> <3AC8BA81.3BC77AC4@mvista.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dan Malek wrote:

> Maybe we should just move this into a separate source file instead of
> making a big configuration mess of the FCC Ethernet driver.  I'm about
> to do that for some 8xx FEC functions as well.

the MII stuff is shared between many other drivers in the Linux kernel.
I've seen PCMCIA hardware that bitbangs some port to play around with
the
PHY registers. So, some generic bitbanging code with callbacks for the
bitsetting would be nice for them.

Have a look at the mii-tool program from the net-tools package!

Cheers /

magnus

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
