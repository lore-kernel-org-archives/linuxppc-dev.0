From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <bigmouth@pionet.net>, <linuxppc-dev-digest@lists.linuxppc.org>
Subject: Re: LinuxPPC and interrupt assignment of non-mac cards (adaptec
 3950U2W)
Date: Tue, 17 Apr 2001 13:10:32 +0200
Message-Id: <20010417111032.10640@mailhost.mipsys.com>
In-Reply-To: <200104162315.SAA24595@mail1.pionet.net>
References: <200104162315.SAA24595@mail1.pionet.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>  Bus  0, device  14, function  0:
>    SCSI storage controller: Adaptec AHA-3940U2 (rev 0).
>      Medium devsel.  Fast back-to-back capable.  BIST capable.  Master
>Capable.  Latency=32.  Min Gnt=39.Max Lat=25.
>      I/O at 0x800 [0x801].
>      Non-prefetchable 64 bit memory at 0x81802000 [0x81802004].
>  Bus  0, device  14, function  1:
>    SCSI storage controller: Adaptec AHA-3940U2 (rev 0).
>      Medium devsel.  Fast back-to-back capable.  BIST capable.  Master
>Capable.  Latency=32.  Min Gnt=39.Max Lat=25.
>      I/O at 0x400 [0x401].
>      Non-prefetchable 64 bit memory at 0x81801000 [0x81801004].

Could be a problem with our code for multifunction devices. Please send
me a dump of /proc/device-tree done with lsprop. (I'm sending you lsprop
source separately).

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
