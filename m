Message-Id: <v04003a08b67ddaff44fe@[24.70.162.12]>
In-Reply-To: <20010106171733.M556@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Sun, 7 Jan 2001 02:57:30 -0600
To: Tom Rini <trini@kernel.crashing.org>,
        Linux/m68k <linux-m68k@lists.linux-m68k.org>,
        linuxppc-dev@lists.linuxppc.org
From: Tony Mantler <nicoya@apia.dhs.org>
Subject: Re: [PATCH] drivers/macintosh/Config.in
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 6:17 PM -0600 1/6/2001, Tom Rini wrote:
>Hey all.  I was wondering what both camps would think of a
>drivers/macintosh/Config.in?  It would simply a few things and remove some
>duplicated bits.  I've attached my first attempt at it, and everything should
>look the same as before (I did rename some of the ADB driver comments from
>the m68k side so they matched the others).
>
>Comments?  (We probably wouldn't see this until 2.5 anyways tho..)

Does the input layer work on the 68k drivers? I don't know that I've ever
heard of anyone testing it.

The patch looks fairly sane to me. If it breaks something, it's not very
hard to fix a config file.


Cheers - Tony 'Nicoya' Mantler :)


--
Tony "Nicoya" Mantler - Renaissance Nerd Extraordinaire - nicoya@apia.dhs.org
Winnipeg, Manitoba, Canada           --           http://nicoya.feline.pp.se/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
