Message-Id: <200008311341.OAA08812@hyperion.valhalla.net>
Date: Thu, 31 Aug 2000 14:41:10 +0100
Subject: Re: Platform configuration (was: Re: CONFIG_PPC != Mac)
From: "Iain Sandoe" <iain@sandoe.co.uk>
To: Benjamin Herrenschmidt <bh40@calva.net>, Gabriel Paubert <paubert@iram.es>,
        "linuxppc-dev" <linuxppc-dev@lists.linuxppc.org>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On  Thu, Aug 31, 2000,  Benjamin Herrenschmidt wrote:

> The only problem is that some HW probe code must be present in the
> bootloader itself to decide which modules to load (well, this could be in
> the bootloader config file, but then, we need a way to load all of them
> for boot CDs).

My vote is for the HW probe - it's harder for the end-user to cock up.  IMHO
Linux has too many config files already.

Iain.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
