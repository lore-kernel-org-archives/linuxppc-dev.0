Message-ID: <392C4A4B.2839C790@embeddededge.com>
Date: Wed, 24 May 2000 17:31:55 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: diekema_jon <diekema@bucks.si.com>
CC: linuxppc-embedded@lists.linuxppc.org, all@cideas.com
Subject: Re: Floating Point problems with Linux on the EST SBC8260
References: <m12uh7W-001SyaC@bucks>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


diekema_jon wrote:

> - What is the state of floating point support with Linux on the
>   MPC8260?

Same as any 603 with FPU.


> Platform: EST SBC8260 w/ MPC8260 Rev A.1 running at 166 Mhz
> Ethernet: 10 Mbs (SCC)
> Linux kernel: 2.3.99-pre9
> root filesystem (NFS mounted): MontaVista Hard Hat Linux version 1.1
> Toolset: Denx Software CDK recompiled with gcc configured for
>          --with-cpu=603e and hard-float (i.e. no --nfp)


You can't be mixing stuff like this.  If you would read the documentation
provided with the MontaVista CDK, you would have discovered that you
need to use the tools, libraries, applications, and file systems with
the kit.  Further, you would have discovered the 1.1 CDK is for an 8xx
and the libraries are compiled for soft (in-line) floating point.  You
are mixing floating point instructions with library and compiler support
that assumes otherwise.......The CDK 1.1 is an update to CDK 1.0.  The
documentation is found in the 1.0 directory.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
