From: Benjamin Herrenschmidt <bh40@calva.net>
To: "Timothy A. Seufert" <tas@mindspring.com>,
        <linuxppc-dev@lists.linuxppc.org>
Subject: Re: usb wheel mouse, XF4.0
Date: Wed, 29 Nov 2000 14:10:42 +0100
Message-Id: <19341024064226.19088@192.168.1.2>
In-Reply-To: <v04220801b64a66c6a467@[10.0.0.42]>
References: <v04220801b64a66c6a467@[10.0.0.42]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>
>The OHCI driver should support literally any standards compliant OHCI
>USB controller found on PCI, whether it's integrated into a
>multifunction IO chip or on a card.  If it doesn't work, there's a
>bug somewhere, either in the hardware (in which case it probably
>doesn't comply to the standard) or in the driver (most likely
>initialization related).

There are various HW bugs in the first revisions of OHCI controllers that
appeared (and so the first USB PCI cards for macs). Looking at Apple driver,
they have a list of vendorIDs/deviceIDs/rev with, for each one, a bitmask of
known "workarounds" to apply depending on the controller. We don't have
such thing in Linux.

>The same principle applies to UHCI.  UHCI could work on PPC, but
>nobody has ever bothered, because the installed base of UHCI
>controllers on PPC boxes approximates zero.  Apple's built-in USB is
>always OHCI, and their MacOS drivers only support OHCI, so anybody
>who wants to market a PCI USB card for Macs uses a OHCI chip to take
>advantage of the drivers written by Apple.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
