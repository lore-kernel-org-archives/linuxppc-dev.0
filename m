Message-ID: <3C7E3DA3.9010800@cambridgebroadband.com>
Date: Thu, 28 Feb 2002 14:24:35 +0000
From: Alex Zeffertt <ajz@cambridgebroadband.com>
MIME-Version: 1.0
To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Development tools version
References: <3C7E3471.4080708@capflow.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Laurent,

We're also use the MPC860.  For the tools we use CDK 2.0 from Montavista, and we've had no problems
with this.  To install CDK 2.0 for the 860 do this:

 > cd /mnt/cdrom/bin
 > ./hhl-host-install
  ... and then select "embeddedplanet-rpxlite" for the board


This provides you with:

i) libraries
ii) a root filesystem for NFS mounting your target
iii) standard tools ppc_8xx-gcc, ppc_8xx-ld, etc.

After this installation all you need to do to compile a linuxppc kernel is change CROSS_COMPILE to
ppc_8xx- in the top level Makefile.

Alex

Laurent Pinchart wrote:

>
> Hi everybody.
>
> I searched the web for some information about this, but haven't been
> able to find any answer to my question.
>
> I'd appreciate if someone could give me an advice about which version of
> the different development tools (namely binutils & gcc), and which
> version of the C library (either glibc or newlib) I should use for a
> MPC860T processor.
>
> I currently use the Hard Hat Journeyman Edition (and recompiled
> everything from the rpm sources), but was wondering if it would be
> better to stick with it or use a newer version of some tools.
>
> I suppose that GCC 3.x is not ready for the MPC8xx yet (but I might be
> wrong).
>
> Thanks in advance for your help.
>
> Laurent Pinchart.
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
