Message-ID: <3ABCF2E1.310E8F29@ncal.verio.com>
Date: Sat, 24 Mar 2001 11:17:53 -0800
From: Henry Worth <haworth@ncal.verio.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: xine, ppc and illegal instructions
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Stefan Berndtsson <stefan@nocrew.org> wrote:

Henry Worth <haworth@ncal.verio.com> writes:

> Shutdown esd (best) or use the -A esd option.

>I'm afraid that doesn't help at all. It still produces >the illegal instruction.
>Hmm.. running it using strace, I can sometimes make it >get past the plugin-
>check and show the box. This nearly never happens with >all the plugins
>available, but gets easier if I remove some of them.

>I'll wait for the new patches and see if that changes >anything though.

Nothing in the patches for this problem, which is
quite recreatable, Bill Fink was looking into
this. If the esd daemon is running (just disabling desktop sounds is not enough, kill the
daemon) and
you run without -A esd, you will get ill. instr.
on ppc, unless running in gdb. ESD is useless
for this anyway, no hope of syncing A/V, at
least till they fix the esd_get_latency() call
which just hangs on both PPC and x86.

BTW - the xine user maillists would be a better
forum for this - <http://xine.sourceforge.net/>
I'm mailing you the cummalative patch.

Henry

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
