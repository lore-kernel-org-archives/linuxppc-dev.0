Message-ID: <3991C809.C240929D@wanadoo.fr>
Date: Wed, 09 Aug 2000 23:07:21 +0200
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: mlan@cpu.lu
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Compile error with Paul's pmac-devel rsync tree
References: <200008091942.VAA06989@piglet.grunz.lu>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners wrote:
>
> Hi all,
>
> Thought I let you all know so you don't have to search for yourself.
> Patch is below...
>
> - There is a problem in compiling ext2 fs support, in fs/ext2/dir.c.
>   This looks like part of a patch submitted to linux-kernel sometime in
>   June. I haven't checked whether this is wrong in kernel.org kernels as
>   well...

I think this has been corrected already earlier today. Just rsync again.
It's funny to look at this in bitkeeper: it has been changed back and
forth several times.

> - The same goes for mark_buffer_dirty_inode() in fs/ext2/truncate.c,
>   which seems to come out of the same patch...

Also fixed as of 8:30 GMT today.

I had sometimes problems loading modules with this version, even with
modutils-2.3.14. I am not quite sure what was the cause, it just didn't
work ("module de4x5 not found"). Sometimes it just worked (I am running
it right now).

Otherwise standard bugs persist:
- No mounting of HFS CDs
- No mounting of loop devices
- No strace

Another bug of Paul's devel tree in comparison with the bitkeeper tree:
There is something wrong with the passing of environment variables. I
have been seeing this at least since 2.4.0-test1-ac18, but I still
haven't quite understood what is going on.

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
