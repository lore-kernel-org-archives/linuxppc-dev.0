From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <khendricks@ivey.uwo.ca>
Cc: <linuxppc-dev@lists.linuxppc.org>, <billfink@capu.net>
Subject: Re: xine, ppc and illegal instructions
Date: Sun, 1 Apr 2001 22:12:53 +0200
Message-Id: <20010401201253.17215@smtp.wanadoo.fr>
In-Reply-To: <01040116021700.15950@localhost>
References: <01040116021700.15950@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>- could there be a cache flushing bug?  When run in gdb if you set some
>breakpoints in the shared library, it will flush the icache (to make sure the
>breakpoint gets flushed out of data cache and any preloaded instruction are
>thrown away) this in turn seems to "fix" the cache flush problem if one
>exists.

Franz and I checked glibc for the cache flushing problem reported by
Samuel Rydth and it's ok. However, the kernel did miss those sync's.
I can't tell if it's the cause of the problem, however, my rsync kernel
have those changes. I'll push them to bk soon.

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
