Date: Sun, 3 Oct 1999 12:23:51 -0700 (MST)
From: Tom Rini <trini@kernel.crashing.org>
To: Eric Dorland <dorland@lords.com>
cc: Elliot Lee <sopwith@redhat.com>, linuxppc-dev@lists.linuxppc.org
Subject: Re: esound for PPC
In-Reply-To: <19991003145409.A511@HSE-MTL-ppp4537.qc.sympatico.ca>
Message-ID: <Pine.LNX.4.10.9910031222340.679-100000@opus.bloom.county>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sun, 3 Oct 1999, Eric Dorland wrote:

> 
> On Sun, Oct 03, 1999 at 12:03:24AM -0400, Elliot Lee wrote:
> > 
> > On Sat, 2 Oct 1999, Eric Dorland wrote:
> > 
> > > With some of the talk changing some of sound driver code, is anyone
> > > working on esound for the PPC. It seems some progress has been made
> > > with 0.2.12, which manages to play some wav files on my machine
> > > (G3/266 DT), but plays garbage for others. Has anyone else seen this
> > > problem, or have gotten esound working properly?
> > 
> > Could you check if there is a correlation between the bit depth of the
> > sound file and the playing-of-garbage-noises? This problem sounds like an
> > audiofile bug.
> 
> It appears you're right. All the sounds that have trouble playing are 16bit
> 44kHz wavs. The weird thing is that if I start esd and use esdplay, all the
> sounds play properly. However the 16bit sounds don't appear to be going
> through esd because I don't get my prompt back until the sound is done
> playing, while the 8bit sounds are played asynchronously.

What happens is either audiofile or esound is doing byte swapping it
doesn't need to.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
