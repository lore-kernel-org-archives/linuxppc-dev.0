Message-ID: <6BAD6986DF8FD211AB8300A0C931D85514E030@mail.neruo.com>
From: Brad Douglas <Brad@NERUO.com>
To: "'James Simmons '" <jsimmons@suse.com>,
        "'Benjamin Herrenschmidt '"
	 <bh40@calva.net>
Cc: "'Geert Uytterhoeven '" <geert@linux-m68k.org>,
        "'Linux Frame Buffer Device Development '" <linux-fbdev@vuser.vu.union.edu>,
        "'Linux/PPC Development '" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: [linux-fbdev] Re: Video driver bug
Date: Mon, 16 Oct 2000 14:21:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Most of us still have a need to know the last (previous) active console.
Maybe change info->currcon to info->lastcon?  Or does the API already give
us the info we need?

I apologize in advance for not looking into this myself.

Brad Douglas
brad@neruo.com
http://www.linux-fbdev.org

-----Original Message-----
From: James Simmons

> While we are at it, I beleive we should also change atyfb.c so that
> currcon is no longer a global. My understanding is that can break
multihead.

That is not the only thing broken for multihead support. The softback code
is severly broken. Also why don't we use the display_fg field in fb_info
instead. display_fg->vc_num is already their is it's more multihead
friendly. IMO real multihead support shoudl wait until 2.5.X since it
needs a pretty big cleanup.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
