Date: Thu, 3 Aug 2000 19:50:01 -0500 (CDT)
From: Takashi Oe <toe@unlserve.unl.edu>
To: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
cc: David Edelsohn <dje@watson.ibm.com>,
        Thomas Graichen <graichen@innominate.de>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: shifts on 64bit ints 
In-Reply-To: <Pine.LNX.3.96LJ1.1b7.1000803193713.650E-100000@ofey.earthlink.net>
Message-ID: <Pine.LNX.3.96LJ1.1b7.1000803194918.650F-100000@ofey.earthlink.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 3 Aug 2000, Takashi Oe wrote:

> On Fri, 4 Aug 2000, Franz Sirl wrote:
>
> > Oh no!! It's even worse! The kernel implementation of ashldi3, ashrdi3 and
> > lshrdi3 seems broken, see this code in arch/ppc/kernel/misc.S:
>
> The brokenness of those implementations has been noted by Gabriel a long
> time ago, and I believe he even sent a fix to this list once.  For some
> unknown reasons, it has largely been ignored.  I think I can dig out his
> patch if I try hard though.

Ok, found it:

http://lists.linuxppc.org/listarcs/linuxppc-dev/199904/msg00189.html

more than a year ago....


Takashi Oe


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
