Date: Tue, 17 Jun 2003 07:34:21 +0200 (CEST)
From: Marius Groeger <mag@sysgo.de>
To: Robin Gilks <robin.gilks@tait.co.nz>
Cc: linuxppc mail list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: lowlat & preeempt
In-Reply-To: <3EEE93C5.4090302@tait.co.nz>
Message-ID: <Pine.LNX.4.56.0306170732170.1316@mag.devdep.sysgo.de>
References: <3EEE93C5.4090302@tait.co.nz>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Tue, 17 Jun 2003, Robin Gilks wrote:

> With the recent release of 2.4.21 I see many patches have been swept up
> and incorporated. No sign of the low latency & preemption patches though
> (not really suprising in a stable series) but does anyone have a set of
> patches for this new tree for ppc only?

The low latency patch is now part of the kpreempt patch. A kpreempt
patch for 2.4.21-pre1 can be found here:

http://www.kernel.org/pub/linux/kernel/people/rml/preempt-kernel/v2.4/

Some tweaks may be required to apply it on the current development
kernel.

Regards,
Marius

--
Marius Groeger <mgroeger@sysgo.de>
Software Engineering

SYSGO Real-Time Solutions AG | Embedded and Real-Time Software
Am Pfaffenstein 14
55270 Klein-Winternheim, Germany

Voice: +49-6136-9948-0 | FAX: +49-6136-9948-10
www.sysgo.de | www.elinos.com | www.osek.de

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
