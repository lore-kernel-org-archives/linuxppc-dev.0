Subject: Re: Using LinuxPPC executables on 8xx processors
To: alan@packetengines.com (Alan Mimms)
Date: Thu, 3 Feb 2000 16:25:32 +1100 (EST)
Cc: linuxppc-embedded@lists.linuxppc.org (Linux PPC Embedded)
In-Reply-To: <0002021816180C.00733@alan.corp.packetengines.com> from "Alan Mimms" at Feb 02, 2000 05:36:13 PM
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000203052532.A3A581B568@elph.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Alan Mimms writes:
> The ONLY way I can see to get MPC8xx kernels to run applications is to use one
> of the prebuilt things from Dan's glibc-1.99, or to build a glibc that has the
> cache line size fixed in memset (the fixit scripts like Wolfgang's do this by
> moving the PowerPC specific one aside and using the generic one that doesn't
> use the cache enhanced zeroing) and in dl-machine.c for the data-to-code
> operation needed after mmap-ing libraries.

I believe you just answered your own question: You can indeed use dynamically
linked LinuxPPC executables directly on MPC8xx targets. However, you need
to rebuild the shared library they link against at runtime as Wolfgang
describes. Note that memset.S and dl-machine.c are in the shared library, and
not in the dynamically linked executables.

Regards,
Graham

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
