Date: Sat, 22 Nov 2003 18:05:15 -0900
From: Ethan Benson <erbenson@alaska.net>
To: linuxppc-dev@lists.linuxppc.org
Subject: Re: setting altivec in .config?
Message-ID: <20031123030515.GE29641@plato.local.lan>
References: <p06002003bbb501deaadc@[192.168.0.254]> <p06010207bbe5d05934b6@[192.168.9.9]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <p06010207bbe5d05934b6@[192.168.9.9]>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Nov 22, 2003 at 09:51:15PM -0500, Stefan Jeglinski wrote:
>
> I wrote:
>
> >I've noticed in the last couple benh kernels that I cannot set
> >altivec to yes or no in the config using xconfig or menuconfig, and
> >that there is no mention of it in the .config file. Also when exiting
> >xconfig, an error is thrown trying to write CONFIG_ALTIVEC. It's all
> >consistent, but what's going on - should it be this way or am I
> >missing the obvious? I can compile, but when I'm building mol it
> >detects the kernel as noav, which feeds my suspicions.
> >
> >I'm currently on 2.4.23-pre5-ben0, old world, with a G4/800 Sonnet
> >upgrade card.
>
> Several things:
>
> a) rsync.penguinppc.org is not a good mirror.

why not?  other then the patch files on kernel.org penguinppc is the
cononical home for benh's rsync tree.  its not a mirror at all, benh
pushes directly to penguinppc.

--
Ethan Benson
http://www.alaska.net/~erbenson/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
