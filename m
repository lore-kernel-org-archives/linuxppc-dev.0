Date: Sun, 30 Jan 2000 07:25:58 -0800 (PST)
From: Brad Midgley <brad@turbolinux.com>
To: Dan Bethe <dan_bethe@yahoo.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: HFS+ format
In-Reply-To: <20000130101504.11105.qmail@web1004.mail.yahoo.com>
Message-ID: <Pine.LNX.4.20.0001300714140.21387-100000@mail.turbolinux.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


i'll bet there is an implementation of hfs+ in the mach layer.

mach needs to understand the filesystem well enough to load the server
from it. i ported hfsutils (yes, the userland stuff) to the mach layer's
bootstrap code back when the only way to install mklinux was with a macos
util and a tarball.  i'll bet mach has an hfs+ implementation (albeit
read-only) in its bootstrap section in darwin.

i realize you're right that the read/write implementation would be in the
bsd layer as i think about it...

the best route may be to enhance hfsutils for hfs+ support. you don't have
to worry about the complexity of multiple readers/writers that way but you
get a useful, practical result. then jump into writing the kernel code
after it works satisfactorily.

brad

> --- Brad Midgley <brad@turbolinux.com> wrote:
> > dan,
> >
> > > 	Is there any tool or technique to help port BSD source to Linux?  Perhaps
> > a
> >
> > are you sure darwin's hfs+ filesystem lies entirely in the bsd layer? (i
> > haven't looked at darwin source)

Brad
brad@turbolinux.com | http://www.turbolinux.com/~brad/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
