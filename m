Message-Id: <200101291550.HAA25459@mail.turbolinux.com>
Date: Mon, 29 Jan 2001 15:58:15 -0000
To: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>,
        Brad Midgley <brad@turbolinux.com>
Subject: Re: pmud monitoring temperature (Re: powerbook doubles)
From: Brad Midgley <brad@turbolinux.com>
Cc: linuxppc-dev@lists.linuxppc.org, djosg@mgu.bath.ac.uk
Reply-To: brad@turbolinux.com
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michael

> gives too long conversion times for slower processors - does this hurt?

the motorola docs suggest waiting too long is fine. (they talk about how the only problem is the
temp may be changing -- but that the temperature only changes at a max 1C/sec)

i think assuming 500mhz is fine.

--
Brad
brad@turbolinux.com      http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
