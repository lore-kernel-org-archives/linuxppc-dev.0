To: "Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Questions about using shell and tools linked with glibc2.1
References: <200001281853.NAA18227@hoover.gilbarco.com>
From: Marcus Sundberg <erammsu@kieraypc01.p.y.ki.era.ericsson.se>
Date: 31 Jan 2000 13:42:55 +0100
In-Reply-To: "Wohlgemuth, Jason"'s message of "Fri, 28 Jan 2000 13:53:24 -0500"
Message-ID: <kfybt62l8ds.fsf@kieraypc07.p.y.ki.era.ericsson.se>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Wohlgemuth, Jason" <jason_wohlgemuth@gilbarco.com> writes:

> I am trying to get my MPC860 board to work with binaries linked against
> glibc2.1.  The kernel has math emulation support and when I pull down a
> prebuilt bash & glibc & libtermcap packages from ftp.linuxppc.org and I try
> to use them I end up hanging.

You can _not_ use a normal glibc on 8xx CPUs. See
http://lists.linuxppc.org/listarcs/linuxppc-embedded/199909/msg00000.html
for info and patches. As you have math emulation in the kernel only
the first part (about cache-lines) is relevant.

//Marcus
--
Signature under construction, please come back later.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
