Date: Mon, 2 Jul 2001 04:35:34 -0700
From: Matt Porter <mporter@mvista.com>
To: Lionel TAILLURAT <lionel.TAILLURAT@ecrin.com>
Cc: ppc_mailing_list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: MVME 5100 & Linux
Message-ID: <20010702043534.A16884@cx258813-a.chnd1.az.home.com>
References: <007d01c102fd$5fe502f0$a66d34c0@zaz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <007d01c102fd$5fe502f0$a66d34c0@zaz>; from lionel.TAILLURAT@ecrin.com on Mon, Jul 02, 2001 at 03:46:16PM +0200
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, Jul 02, 2001 at 03:46:16PM +0200, Lionel TAILLURAT wrote:
> I'm trying to install the Debian PPC Linux 2.2R0 on an MVME5100 + MVME 761 +
> IPMC 761.
>
> For that I download the Prep Image by TFTP, and the only thing I have is :
>
> PPC6-Bug>nbo
> Network Booting from: I82559, Controller 0, Device 0
> Device Name: /pci@fe000000/pci8086,1209@e,0:0,0
> Loading: bootfull.bin

Whoa.  The 5100 is not a PReP-like system even though it has the
capability to boot an image with a PReP header on it.  You're
trying to boot Debian/PPC's old 2.2 kernel on this system that
is an a CHRP memory map and has UARTs at non-standard locations.
That's not going to work.

> I have seen in the Mailing list archive that there was some problems using
> Linux with the MVME 5100 and especially with the residual data.
>
> Is there is a correction of this problem ?
>
> What should I do to have Linux working with this board ?

You should use the MVME5100 port from the linuxppc_2_4_devel tree.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
