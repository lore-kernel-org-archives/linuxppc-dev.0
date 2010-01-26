Return-Path: <Dan.Geer@faa.gov>
Received: from relay2.faa.gov (relay2.faa.gov [204.108.10.7])
	by ozlabs.org (Postfix) with ESMTP id DAF9BB7D86
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 27 Jan 2010 09:04:58 +1100 (EST)
In-Reply-To: <4B5F58B0.9090401@freescale.com>
Subject: Re: BSE-IP
To: Scott Wood <scottwood@freescale.com>
Message-ID: <OF54D7A55A.FE6F4A1D-ON852576B7.00781D7D-852576B7.00794B17@faa.gov>
From: Dan.Geer@faa.gov
Date: Tue, 26 Jan 2010 17:04:50 -0500
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> > My end goal is to run the latest 2.6.32 kernel on an ancient BSE-IP
MPC823
> > board.  One step in the process is an attempt to compile the last
"working"
> > kernel for this platform, and it hasn't been pretty.
> >
> > Back in 2005, Kumar Gala caught an issue with compiling for this
platform,
> > and Dan Malek commented about which options to choose to complete a
> > successful compile.  I'm in the process of trying to get that
(2.6.16.62)
> > series to work.  It seems that one of the newer dev boards got the
focus of
> > the port, and the BSE-IP drop out of sight.
>
> Newer boards have been used for recent development, but it shouldn't be
> too hard to get other boards to work.  With the device tree, a lot more
> of the hardware description is done in a data structure, rather than
> scattered throughout code.
>
> I'd start by taking one of the existing supported 8xx boards in the
> current tree, and adapting its device tree and platform file to describe
> the BSE-IP, using the old code as a reference.  You may also need
> bootwrapper changes, depending on what firmware you use.

Any idea of the last kernel version that worked?  So I know I can count on
that as a reference?  I have the 2.2 pre7 from BSE, but there have been a
few changes since. ;^)

It appears the image (bootwrapper) needs to be completely self-contained,
and needs to understand how to read the flash parameters.  That's on my
list.

> Things have changed enough that I don't recommend trying to directly
> merge the old code into the new kernel.

Understood.

> -Scott

=Dan
