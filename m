Date: Thu, 19 Dec 2002 11:30:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Claudia Salzberg <sentinel@jump.net>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mapping back to 36 bit physical
Message-ID: <20021219183034.GH852@opus.bloom.county>
References: <Pine.LNX.4.33.0212181358270.23138-100000@grandmaster.protagonist.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0212181358270.23138-100000@grandmaster.protagonist.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Dec 18, 2002 at 02:07:45PM +0600, Claudia Salzberg wrote:

> Greetings.
> How does one go about aquiring the 36-bit physical address on a 440XX if
> you have the corresponding va from an ioremap (when your driver is not
> the one that did the ioremap so that you don't have the pa saved)? ?I see
> that ioremap does support 36-bit I/O mapping but _va and _pa only play
> with unsigned long's. ?So does iopa. ?So do the virt_to_* 's I was able
> to find. ?Also, does anyone have plans for incorporating memory access
> hooks above 4GB address space?

Erm.  Have you looked at the code in the linuxppc_2_4_devel tree?  I
believe all of these issues have already been addressed.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
