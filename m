Date: Sun, 7 Jan 2001 17:38:05 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Tony Mantler <nicoya@apia.dhs.org>
Cc: Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] drivers/macintosh/Config.in
Message-ID: <20010107173805.B19404@opus.bloom.county>
References: <20010106171733.M556@opus.bloom.county> <v04003a08b67ddaff44fe@[24.70.162.12]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <v04003a08b67ddaff44fe@[24.70.162.12]>; from nicoya@apia.dhs.org on Sun, Jan 07, 2001 at 02:57:30AM -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Jan 07, 2001 at 02:57:30AM -0600, Tony Mantler wrote:
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

Well, it should.  It was in the menu :)

> The patch looks fairly sane to me. If it breaks something, it's not very
> hard to fix a config file.

Right.  I just wanna make sure everyone like the way it looks.  I also (may)
move things like MOL into that file.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
