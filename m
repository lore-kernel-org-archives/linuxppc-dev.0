Date: Sun, 3 Oct 1999 14:54:09 -0400
From: Eric Dorland <dorland@lords.com>
To: Elliot Lee <sopwith@redhat.com>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
Message-ID: <19991003145409.A511@HSE-MTL-ppp4537.qc.sympatico.ca>
References: <19991002234842.A786@HSE-MTL-ppp4503.qc.sympatico.ca> <Pine.LNX.4.10.9910030000240.18294-100000@lacrosse.corp.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.10.9910030000240.18294-100000@lacrosse.corp.redhat.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, Oct 03, 1999 at 12:03:24AM -0400, Elliot Lee wrote:
> 
> On Sat, 2 Oct 1999, Eric Dorland wrote:
> 
> > With some of the talk changing some of sound driver code, is anyone
> > working on esound for the PPC. It seems some progress has been made
> > with 0.2.12, which manages to play some wav files on my machine
> > (G3/266 DT), but plays garbage for others. Has anyone else seen this
> > problem, or have gotten esound working properly?
> 
> Could you check if there is a correlation between the bit depth of the
> sound file and the playing-of-garbage-noises? This problem sounds like an
> audiofile bug.

It appears you're right. All the sounds that have trouble playing are 16bit
44kHz wavs. The weird thing is that if I start esd and use esdplay, all the
sounds play properly. However the 16bit sounds don't appear to be going
through esd because I don't get my prompt back until the sound is done
playing, while the 8bit sounds are played asynchronously.

> Also, if people would please try out GNOME 1.0.50 this weekend and find
> any PPC-specific problems ASAP, it'd be much appreciated.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
