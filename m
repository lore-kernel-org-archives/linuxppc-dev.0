Date: Thu, 20 Feb 2003 12:36:11 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Kent Borg <kentborg@borg.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Bringing up Motorola MGT5100
Message-ID: <20030220193611.GB24845@ip68-0-152-218.tc.ph.cox.net>
References: <20030220142703.A24949@borg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20030220142703.A24949@borg.org>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 20, 2003 at 02:27:03PM -0500, Kent Borg wrote:

> I am working on bringing up Linux on a Motorola MGT5100 board.  It's
> core is roughly a 603e, with lots of other devices on the chip.
>
> I am using an Abatron and have a question about really early boot.
> When the MMU is first turned and we are executing at 0xC-bazillion the
> Abatron can't read the contents of those addresses.  Is this a dark
> time when the Abatron isn't expected to be able to read that memory,
> or do I have the MMU or Abatron set up wrong?  (I can single step and
> put hardware breakpoints up there.)

Bad config.  Can you post it please?

--
Tom Rini
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
