Date: Mon, 21 Jan 2002 12:30:42 -0700
From: Matt Porter <mporter@mvista.com>
To: Mark Pilon <mpilon@midrivers.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: KERNELBASE & large memory systems
Message-ID: <20020121123042.A3535@cx258813-a.chnd1.az.home.com>
References: <3C4A96D7.9010501@embeddededge.com> <3C4C2EB6.6F3ACADE@midrivers.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3C4C2EB6.6F3ACADE@midrivers.com>; from mpilon@midrivers.com on Mon, Jan 21, 2002 at 08:07:34AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jan 21, 2002 at 08:07:34AM -0700, Mark Pilon wrote:
>
> I've heard that one shouldn't modify the definition of KERNELBASE
> as it screws up the MM code;
>
> I'm wondering how people out there are handling designing systems
> (and getting linux running) on large pools of memory -- like
> 1 - 2 Gb or so.
>
> 0xc0000000 - 0xFFFFFFFF is 1Gb; has anyone redefined KERNELBASE
> lower to allow for more memory in a system?

If you simply need to handle more DRAM just turn on CONFIG_HIGHMEM.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
