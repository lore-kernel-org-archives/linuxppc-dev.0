Message-ID: <3DD939B5.3D1F2B6E@paradyne.com>
Date: Mon, 18 Nov 2002 14:04:21 -0500
From: "Mark D. Studebaker" <mds@paradyne.com>
MIME-Version: 1.0
To: Joakim Tjernlund <Joakim.Tjernlund@lumentis.se>
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org, sensors@stimpy.netroedge.com
Subject: Re: 8xx i2c refers to unspecified chip errata
References: <IGEFJKJNHJDCBKALBJLLMEFNFHAA.joakim.tjernlund@lumentis.se> <3DD8014B.D88A6C34@paradyne.com> <001101c28e82$88d2bc40$0200a8c0@telia.com> <20021118141042.GA15279@opus.bloom.county>
Content-Type: multipart/mixed;
 boundary="------------57CCE21CC6A2BFB280B33AF2"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


This is a multi-part message in MIME format.
--------------57CCE21CC6A2BFB280B33AF2
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

whatever your patch was against didn't match our tree very well. would
you please
resolve the differences and generate a new patch against our tree?
thanks
mds

Tom Rini wrote:
>
> On Sun, Nov 17, 2002 at 10:44:40PM +0100, Joakim Tjernlund wrote:
>
> > > Tom + Joakim,
> > > we're doing a release soon over here at sensors/i2c,
> > > do you want this checked in as-is, with mods, or not at all?
> >
> > As-is for me. No problems reported to me.
>
> Works for me then.
>
> --
> Tom Rini (TR1265)
> http://gate.crashing.org/~trini/
--------------57CCE21CC6A2BFB280B33AF2
Content-Type: text/plain; charset=us-ascii;
 name="fail"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="fail"

patching file i2c-algo-8xx.c
Hunk #1 FAILED at 7.
Hunk #2 FAILED at 27.
Hunk #3 succeeded at 74 with fuzz 2 (offset 14 lines).
Hunk #5 succeeded at 157 (offset 18 lines).
Hunk #6 FAILED at 177.
Hunk #8 succeeded at 220 (offset 18 lines).
Hunk #9 FAILED at 237.
Hunk #10 succeeded at 333 (offset 2 lines).
Hunk #11 FAILED at 343.
Hunk #12 FAILED at 359.
Hunk #13 succeeded at 439 (offset 18 lines).
Hunk #14 FAILED at 464.
Hunk #15 succeeded at 514 (offset 2 lines).
7 out of 15 hunks FAILED -- saving rejects to file i2c-algo-8xx.c.rej


--------------57CCE21CC6A2BFB280B33AF2--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
