Date: Fri, 23 Nov 2001 19:08:36 -0700 (MST)
From: Derrik Pates <dpates@dsdk12.net>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: Again with the firewire
In-Reply-To: <20011122182111.9961@mailhost.mipsys.com>
Message-ID: <Pine.LNX.4.40.0111231904220.14868-100000@andromeda.dsdk12.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 22 Nov 2001, Benjamin Herrenschmidt wrote:

> In Stefan's case, it appears to be the transmit DMA of the chip stalling
> for some unknown reason. I suggest moving that discussion to the
> linux1394-devel list as I really don't know what may be going on.

After another test on my part, I discovered that I am not seeing a freeze
on hotplugging. Probably put this iBook to sleep before I plugged the CD
burner in, and the FireWire controller was already a lost cause.

Also, a heads up - I've found that unloading 'ohci1394' before suspend and
reloading it after yields a working system, no freezes after unsuspend. At
least on this FireWire iBook, anyway. If I don't, the system hangs after
unsuspending as soon as a FireWire device is accessed. May be useful for
suspend handling in the driver itself.

Derrik Pates      |   Sysadmin, Douglas School   |    #linuxOS on EFnet
dpates@dsdk12.net |     District (dsdk12.net)    |    #linuxOS on OPN


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
