Date: Thu, 4 Dec 2003 17:34:33 +0100
From: Samuel Rydh <samuel@ibrium.se>
To: linuxppc-dev@lists.linuxppc.org
Cc: benh@kernel.crashing.org
Subject: Re: USB, 2.6-test11 and hot flaming death
Message-ID: <20031204163433.GA21236@ibrium.se>
References: <1070080961.683.26.camel@gaston> <09B6571B-2408-11D8-970C-0003939E069A@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <09B6571B-2408-11D8-970C-0003939E069A@mac.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Dec 01, 2003 at 08:09:54AM -0600, tom_gall@mac.com wrote:
>
> On Friday, November 28, 2003, at 10:43 PM, Benjamin Herrenschmidt wrote:
>
> >
> >On Sat, 2003-11-29 at 06:07, tom_gall@mac.com wrote:
> >>Current pull of test11 and test10 will at boot up give the following
> >>error messages :
> >>
> >>hid: probe of 4-1.1:1.1 failed with error -5
> >>hub 4-1:1.0: hub_port_status failed (err = -108)
> >>hub 4-1:1.0: hub_port_status failed (err = -108)
> >>hub 4-1:1.0: hub_hub_status failed (err = -108)
> >>hub 4-1:1.0: get_hub_status failed
> >>hub 4-1:1.0: hub_port_status failed (err = -108)
> >>usb 4-1: USB disconnect, address 2
> >>usb 4-1.1: USB disconnect, address 3
> >
> >This is new to test11 ?
>
> Nope, effects test10 and test-11.

This problem has actually been present quite a while (at least
since 2.6.0-test3). On my dual 1.25 GHz G4, it occurs once
every four boots or so.

/Samuel

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
