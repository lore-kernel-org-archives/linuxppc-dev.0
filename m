To: Conn Clark <clark@esteem.com>
Cc: May Ling List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Is there a new G4 that supports DDR SDRAM?
References: <3D5995D0.8D9C2ED6@esteem.com>
From: Roland Dreier <roland@topspin.com>
Date: 16 Aug 2002 10:02:40 -0700
In-Reply-To: <3D5995D0.8D9C2ED6@esteem.com>
Message-ID: <52bs82virz.fsf@topspin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>>>>> "Conn" == Conn Clark <clark@esteem.com> writes:

    Conn> Apple just released there new Macs with DDR SDRAM
    Conn> support. Does that mean there is a new G4 that supports DDR
    Conn> SDRAM ? Apple has to be using a new G4 because they claim a
    Conn> 1.25GHz clock speed and a 166MHz FSB clock rate.  Any body
    Conn> heard anything about this?

For "G4" PPC chips (really Motorola 74xx) the RAM controller is on a
separate companion chip.  For example Marvell's Discovery 2 companion
chip supports DDR and works with Mororola 74xx and IBM 750 chips.

However, the fastest Motorola 7455 chips I've heard of are 1 GHz with
a 133 MHz bus.  Perhaps the new Macs are using CPUs available only to
Apple?

 - Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
