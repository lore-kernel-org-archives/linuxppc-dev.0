Message-ID: <39F3A9F7.8F150990@mvista.com>
Date: Sun, 22 Oct 2000 23:01:11 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Chris Hallinan <clh@net1plus.com>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC850 SIMASK Settings
References: <NEBBKJPFOLJNBMFNKBIIEENICDAA.clh@net1plus.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Chris Hallinan wrote:
>
> I'm having trouble disabling an external interrupt (IRQ7).

Why are you trying to do this directly instead of letting the
generic Linux functions do it for you?  All you should have to
do is set edge/level in SIEL.  The rest is already managed.

If an interrupt handler is installed for this interrupt, it
will be allowed to happen.  If the handler is removed, it will
be permanently masked.


	-- Dan

--

	I like MMUs because I don't have a real life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
