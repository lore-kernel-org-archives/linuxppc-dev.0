Message-ID: <374ADD94.BE39D764@univ-rennes1.fr>
Date: Tue, 25 May 1999 18:27:48 +0100
From: Martin Costabel <Martin.Costabel@univ-rennes1.fr>
Reply-To: costabel@wanadoo.fr
MIME-Version: 1.0
To: laures@esiea.fr
CC: linuxppc-user@lists.linuxppc.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Releasing more easy kernel patches
References: <199905221002.FAA22379@lists.linuxppc.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


laures@esiea.fr wrote:
> 
> Hi,
> 
> I like to try patches on my various kernels. Unfortunately for the mid
> power users like me, it's not always possible to get the bleeding edge
> source tree for cvs, and anyway patches does not seem to be
> always released against this tree.
> 
> As Linuxppc-pre-R5 "ships" with a kernel source that has usb and pcmcia
> stuff (so it's fairly complete), I think it would be reasonable to use
> this tree (which is easy to get and install as well) as a reference for
> all patches released for public testing here (I'm not talking of
> linuxppc-dev).

I think this is a good idea, but why not take the reference release as a
reference? I think right now this is the same thing (rpms version
2.2.6-15a in ftp://ftp.linuxppc.org/linuxppc-dev-rel/1.0/RedHat/RPMS/ or
one of its mirrors), but I have the impression that pre-R5 may change
anytime without notice, whereas RR-1.0 should be a bit more stable
(until, of course, LinuxPPC-R5 hits the net :-)).

> I feel this need because the new sound/brightness patch for PowerBook
> didn't apply without any fuss into this kernel, mac-on-linux gives tons
> of redefinition warnings (although the kernel works fairly well), there
> were minor problems with latest Geert's aty patch etc etc.
> I would be really more confident if the patches were released
> specifically for my version of the kernel.
> 
> If hard kernel hackers don't find the time to do that by themselves,
> it's ok to send me the patch and I'll try to get the "correct" patch as
> soon as posible. (be prepared to questions then...)
[patch deleted]

--
Martin
P.S. Did you really send your message on last Saturday? It arrived only
today in my mailbox.

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
