Message-ID: <3BB88D51.6EDB09AF@aps.anl.gov>
Date: Mon, 01 Oct 2001 10:35:45 -0500
From: Andrew Johnson <anj@aps.anl.gov>
MIME-Version: 1.0
To: Ofer Rashuk <OferR@Radlan.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel panic while Booting 8240
References: <42AB6BE23C29D511831E0002B3202488199989@messenger.radlan.co.il>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Ofer Rashuk wrote:
>
> I'm using 8240 on a costume board with Monta Vista LSP.
> while booting after system has been mounted i am receiving an Kernel Panic.

Check that your target's /sbin directory actually has an init binary in it
- I had problems when installing the Sandpoint LSP which meant that a
third of the binaries were missing (/bin/mount was another example).  I
had to install some of the RPMs by hand to fix this.

- Andrew
--
Perfection is reached, not when there is no longer anything to add,
but when there is no longer anything to take away.
- Antoine de Saint-Exupery

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
