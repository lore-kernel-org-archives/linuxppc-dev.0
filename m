Date: Sat, 16 Feb 2002 17:11:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
Cc: linuxppc-dev@lists.linuxppc.org,
	yellowdog-devel@lists.yellowdoglinux.com
Subject: Re: question on best way to install other ide drives?
Message-ID: <20020217001156.GB12769@opus.bloom.county>
References: <40041092-2284-11D6-9EE3-0003938E434C@ivey.uwo.ca> <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <453D45A8-2339-11D6-B84B-0003938E434C@ivey.uwo.ca>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Feb 16, 2002 at 06:59:53PM -0500, Kevin B. Hendricks wrote:

> Would it be better (performancewize) to:
>
> A.  Hook both drives up the the ATA-100 pci card using two ribbon cables
> with both being masters?

No difference probably, If you can boot from the sonnet card.

> B.  Hook only 1 to the ATA-100 (a master) and use the second as slave
> off the the included IDE card?
>
> C. Hook both to one ATA-100 card using one as master and one as slave.

Erm, unless you've got some horribly fast IDE drives (and use Andres IDE
patches which means you can't use onboard IDE on pmacs just yet, iirc),
your best bet is either:
a) Throw your other drive in as a slave under the CDRW/DVD, if that bay
is empty.
b) Hook up the drive as a slave to the primary.
c) Throw in the IDE card, and put another drive in as master.

I've done 'a' on the 3 G3s/G4s I've owned, and never really had a
problem (one drive _might_ have gotten pissy after being there for a few
years, but I never could verify what was causing the wierd issues).

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
