From: Joe Green <jgreen@mvista.com>
To: bjowi@ida.liu.se (Bj?rn Wingman),
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: cpci network
Date: Wed, 21 Mar 2001 11:08:09 -0800
Content-Type: text/plain
References: <yx27l1llncp.fsf@aste15.ida.liu.se>
In-Reply-To: <yx27l1llncp.fsf@aste15.ida.liu.se>
MIME-Version: 1.0
Message-Id: <01032111141400.03219@minotaur.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Björn Wingman wrote:
> Is anyone using cnet from compactnet.com or hhnet from mvista.com for
> network over the pci bus?
>
> The sources avaliable at ftp://ftp.mvista.com/pub/hhnet/ are fairly
> old, and are incompatible with newer kernels, like 2.4 or 2.5.

It's not too tough a port, though.  We've been incorporating hhnet into
the kernel when we do a major release, and haven't been updating the
separate package on the FTP site.

> Is this/will it be incorporated/ported to the newer kernels?

Yes.

> Is there some other way to build a network over a (compact)pci bus, more
> specifically the 21554, which hhnet supports?

One of the reasons we haven't been extending hhnet significantly is
that we've been working with PICMG, the CompactPCI standards group, to
develop a backplane networking standard.  The new standard will allow
communication between different OS's and architectures.  (hhnet works
with multiple architectures, but only on Linux.)  We expect that when
it's complete this new standard will supplant hhnet for most
applications.

--
Joe Green <jgreen@mvista.com>
MontaVista Software, Inc.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
