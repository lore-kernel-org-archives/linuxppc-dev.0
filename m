Date: Wed, 29 Jan 2003 15:13:35 +0100 (CET)
From: Marius Groeger <mag@sysgo.de>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Can software discover MPC8xx variant?
In-Reply-To: <1043848594.10504.41.camel@zambia>
Message-ID: <Pine.LNX.4.52.0301291512130.9598@mag.devdep.sysgo.de>
References: <1043848594.10504.41.camel@zambia>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 29 Jan 2003, Alex Zeffertt wrote:

> Can anybody tell me if there is a way to identify which processor from
> the MPC8xx family software is running on.  I hoped I could use the IMMR
> special purpose register.  However, this only tells you the silicon
> revision, which can have the same value even if the processors are
> different!
>
> Does the processor type (e.g. 862, 857T, 857DSL) reside anywhere in the
> processor?

U-Boot/PPCboots cpu/mpc8xx/cpu.c contains a lot of generic type
detection code, but even there the assumes that the basic type is
known at compile time.

Regards,
Marius

-----------------------------------------------------------------------------
Marius Groeger           SYSGO Real-Time Solutions AG       mgroeger@sysgo.de
Software Engineering     Embedded and Real-Time Software    www.sysgo.de
Voice: +49-6136-9948-0   Am Pfaffenstein 14                 www.osek.de
FAX:   +49-6136-9948-10  55270 Klein-Winternheim, Germany   www.elinos.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
