Subject: Re: userspace testing an ati fb driver
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Eger <random-temp_addy-1071230825.92d33e@theboonies.us>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <1070626021.3fd074e539732@mail.theboonies.us>
References: <1070626021.3fd074e539732@mail.theboonies.us>
Content-Type: text/plain
Message-Id: <1070760089.11004.19.camel@gaston>
Mime-Version: 1.0
Date: Sun, 07 Dec 2003 12:21:30 +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Fri, 2003-12-05 at 23:07, David Eger wrote:
> I think this explains my problem;  output from my reg dump:

Are you properly endian-flipping register accesses ? My access
macro use the lwbrx/stwbrx instructions that to the endian flipping
automatically.

> Radeon MMIO registers:
> 0000 : 0000c081
> 0004 : 00313131
> 0008 : 3f000000
> ...
>
> output from your reg dump:
>
> Radeon MMIO registers:
> 0000 : 81c00000
> 0004 : 31313100
> 0008 : 0000003f
> ...

--
Benjamin Herrenschmidt <benh@kernel.crashing.org>

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
