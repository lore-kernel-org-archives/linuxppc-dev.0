Message-ID: <39995D1C.3006207E@embeddededge.com>
Date: Tue, 15 Aug 2000 11:09:16 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Graham Stoney <greyham@research.canon.com.au>
CC: LinuxPPC Embedded Mailing List <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Journeyman configure/build options for gcc & glibc?
References: <20000815073750.58C33274@elph.research.canon.com.au>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Graham Stoney wrote:
>
> I thought I had the whole soft-float thing on 8xx worked out long ago, until I
> upgraded our root filesystem to the one from MontaVista's Journeyman kit,

The lastest CDK 1.2 has been released, so you may want to use that.

The MontaVista CDK is created to work as a complete kit.  I don't know
all of the details, but the binutils, compilers, run-time start up,
libraries, header files, and applications are all built to work together.
There is an 8xx set of everything that "just works" together.  Mixing
among various tools/libraries has never worked at any time in history and
that continues to be the case.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
