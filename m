Date: Sun, 3 Oct 1999 00:03:24 -0400 (EDT)
From: Elliot Lee <sopwith@redhat.com>
To: Eric Dorland <dorland@lords.com>
cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
In-Reply-To: <19991002234842.A786@HSE-MTL-ppp4503.qc.sympatico.ca>
Message-ID: <Pine.LNX.4.10.9910030000240.18294-100000@lacrosse.corp.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2 Oct 1999, Eric Dorland wrote:

> With some of the talk changing some of sound driver code, is anyone
> working on esound for the PPC. It seems some progress has been made
> with 0.2.12, which manages to play some wav files on my machine
> (G3/266 DT), but plays garbage for others. Has anyone else seen this
> problem, or have gotten esound working properly?

Could you check if there is a correlation between the bit depth of the
sound file and the playing-of-garbage-noises? This problem sounds like an
audiofile bug.

Also, if people would please try out GNOME 1.0.50 this weekend and find
any PPC-specific problems ASAP, it'd be much appreciated.
-- Elliot					http://developer.gnome.org/
The first thing a programmer needs to admit is that any program is by far
more complex than his own mind. Thats why he partitions it into neat
pieces and avoids complexity.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
