Date: Mon, 3 Jul 2000 17:43:04 +1000
From: Chris Leishman <masklin@debian.org>
To: Benjamin Herrenschmidt <bh40@calva.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: [ANN] New kernels, gmac, airport, usb...
Message-ID: <20000703174304.A6763@freeonline.com.au>
References: <20000702184313.25718@192.168.1.10>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20000702184313.25718@192.168.1.10>; from bh40@calva.net on Sun, Jul 02, 2000 at 08:43:13PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jul 02, 2000 at 08:43:13PM +0200, Benjamin Herrenschmidt wrote:
<snip>
> On this page, you'll also find an Airport driver for the Apple Airport
> card. It has been successfully tested with a Pismo powerbook, an iBook
> and a G4 "Sawtooth". You need the latest kernel for it to work correctly,
> and you should have this kernel's sources linked to /usr/src/linux in
> order to compile it (it's downloadable in source form only). Useage is
> similar to the wvlan_cs driver for the Lucent PCMCIA card, the interface
> name is 'airport'.
>

Is the airport driver based on the latest wvlan_cs?  Your page indicates that
WEP is not supported, although the latest wvlan_cs does appear to support WEP.

Regards,

Chris

--
----------------------------------------------------------------------
            Linux, because I'd like to *get there* today
----------------------------------------------------------------------
Reply with subject 'request key' for GPG public key.  KeyID 0xB4E24219

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
