Message-ID: <3A592881.91E8EBD4@speakeasy.org>
Date: Sun, 07 Jan 2001 21:40:01 -0500
From: Ray Knight <audilvr@speakeasy.org>
MIME-Version: 1.0
To: Tony Mantler <nicoya@apia.dhs.org>
CC: Tom Rini <trini@kernel.crashing.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] drivers/macintosh/Config.in
References: <v04003a08b67ddaff44fe@[24.70.162.12]>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Tony Mantler wrote:
>
> At 6:17 PM -0600 1/6/2001, Tom Rini wrote:
> >Hey all.  I was wondering what both camps would think of a
> >drivers/macintosh/Config.in?  It would simply a few things and remove some
> >duplicated bits.  I've attached my first attempt at it, and everything should
> >look the same as before (I did rename some of the ADB driver comments from
> >the m68k side so they matched the others).
> >
> >Comments?  (We probably wouldn't see this until 2.5 anyways tho..)
>
> Does the input layer work on the 68k drivers? I don't know that I've ever
> heard of anyone testing it.
>
> The patch looks fairly sane to me. If it breaks something, it's not very
> hard to fix a config file.
>
> Cheers - Tony 'Nicoya' Mantler :)
>

The input layer doesn't currently compile on the m68k Macs.  (undefined
variables)  I didn't look to closely at it because right now I'm just
trying to get a 2.4.0 kernel that will boot.  I'll go back and take a
better look at that when I reach my goal of getting a bootable kernel on
an LC475.

--
Ray Knight
audilvr@speakeasy.org
Linux-Mac68k Developer

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
