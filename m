Return-Path: <dgibson@ozlabs.org>
Date: Thu, 1 Mar 2007 10:38:01 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: [RFC] powerpc: Document new property called interrupt-parents
Message-ID: <20070228233801.GC3048@localhost.localdomain>
References: <200702272254.l1RMsjt2030709@ld0164-tx32.am.freescale.net>
	<20070228005615.GE11775@localhost.localdomain>
	<9696D7A991D0824DBA8DFAC74A9C5FA302AA071F@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA302AA071F@az33exm25.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Feb 28, 2007 at 08:56:55AM -0700, Yoder Stuart-B08248 wrote:
> 
> > -----Original Message-----
> > From: David Gibson [mailto:david@gibson.dropbear.id.au] 
> > Sent: Tuesday, February 27, 2007 6:56 PM
> > To: Yoder Stuart-B08248
> > Cc: paulus@samba.org; linuxppc-dev@ozlabs.org
> > Subject: Re: [RFC] powerpc: Document new property called 
> > interrupt-parents
> > 
> > On Tue, Feb 27, 2007 at 04:54:45PM -0600, Stuart Yoder wrote:
> > > 
> > > Document new property called interrupt-parents which can
> > > be used to represent interrupts for devices that route
> > > interrupts to more than one interrupt controller.
> > 
> > Well, whatever Segher says, I'm still very concerned about the
> > potential for extra difficulty in debugging with this approach.
> 
> The issue, as I understand it, is the potential for an old
> kernel parser to silently misparse a new dev tree with this
> new property.
> 
> Do the version and last_comp_version in the blob header
> help here?

Unfortunately not.  Those fields version the the serialization format
of the device tree, not the content of the device tree.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
