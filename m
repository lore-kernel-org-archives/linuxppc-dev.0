Date: Wed, 29 Aug 2001 08:56:26 -0700
From: Matt Porter <mporter@mvista.com>
To: Xavier Grave <grave@ipno.in2p3.fr>
Cc: embarque ppc <linuxppc-embedded@lists.linuxppc.org>,
	clavelin@ipno.in2p3.fr
Subject: Re: trying to boot linux on a MVME5100
Message-ID: <20010829085626.A31027@cx258813-a.chnd1.az.home.com>
References: <20010829165002.A17350@ipnpcu5.in2p3.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20010829165002.A17350@ipnpcu5.in2p3.fr>; from grave@ipno.in2p3.fr on Wed, Aug 29, 2001 at 04:50:02PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 29, 2001 at 04:50:02PM +0200, Xavier Grave wrote:
>
> Hi,
>
> I've just received a new MVME5100 board and I'm trying to boot it under
> linux.
>
> I have downloaded the linuxppc_2_4_devel tree from the bitkeeper
> repository.
> I have compiled a kernel from the mvme5100_defconfig with a few
> modifications.
> I'm trying to boot it with nbo under ppc bug.
>
> Nothing occurs...
> the nping command function. And I usually do the same with a 2303 board
> without problem.

Network commands in PPCBUG won't function until you set the time (i.e.
start the RTC) on a virgin board.  Use PPCBUG's 'SET' command to
accomplish this.  This is described on page 3-213 (pdf page 289) of
the PPCBUG User's Manual at
http://www.mcg.mot.com/us/products/docs/pdf/ppcbuga.pdf

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
