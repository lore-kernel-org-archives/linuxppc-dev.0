Date: Mon, 16 Oct 2000 18:31:18 -0700 (PDT)
From: James Simmons <jsimmons@suse.com>
To: Brad Douglas <Brad@NERUO.com>
Cc: "'Benjamin Herrenschmidt '" <bh40@calva.net>,
        "'Geert Uytterhoeven '" <geert@linux-m68k.org>,
        "'Linux Frame Buffer Device Development '" <linux-fbdev@vuser.vu.union.edu>,
        "'Linux/PPC Development '" <linuxppc-dev@lists.linuxppc.org>
Subject: RE: [linux-fbdev] Re: Video driver bug
In-Reply-To: <6BAD6986DF8FD211AB8300A0C931D85514E030@mail.neruo.com>
Message-ID: <Pine.LNX.4.21.0010161820270.319-100000@euclid.oak.suse.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> Most of us still have a need to know the last (previous) active console.
> Maybe change info->currcon to info->lastcon?  Or does the API already give
> us the info we need?

No the API does not give this info. As for multihead their is nothing you
can do really. At this point we should just label the console system and
fbcon as not supporting multihead. Their are far to many problems with
multihead to fix. currcon or lastcon. It doesn't really matter at this
point. Multihead is just broken :-(


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
