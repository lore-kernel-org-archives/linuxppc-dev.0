Date: Thu, 20 Feb 2003 12:55:23 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bringing up Motorola MGT5100
Message-ID: <20030220195523.GD24845@ip68-0-152-218.tc.ph.cox.net>
References: <20030220142703.A24949@borg.org> <20030220193611.GB24845@ip68-0-152-218.tc.ph.cox.net> <20030220144812.D24949@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030220144812.D24949@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 20, 2003 at 02:48:12PM -0500, Kent Borg wrote:

[snip]
> [TARGET]
> CPUTYPE     5100        ;the CPU type

Are you sure you want this?  Maybe it should be '603'..

> ;MMU         XLAT	;translate effective to physical address
> PTBASE      0x000000f0  ;here is the pointer to the page table pointers

Keep the MMU line, comment out the PTBASE maybe?

I'm not sure 'tho..

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
