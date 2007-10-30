Return-Path: <dgibson@ozlabs.org>
Date: Tue, 30 Oct 2007 11:29:21 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Yoder Stuart-B08248 <stuart.yoder@freescale.com>
Subject: Re: RFC:  replace device_type with new "class" property?
Message-ID: <20071030002921.GD29263@localhost.localdomain>
References: <9696D7A991D0824DBA8DFAC74A9C5FA30359F9BB@az33exm25.fsl.freescale.net>
	<47262E36.4030503@genesi-usa.com>
	<9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9696D7A991D0824DBA8DFAC74A9C5FA30359FB6A@az33exm25.fsl.freescale.net>
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 29, 2007 at 12:34:40PM -0700, Yoder Stuart-B08248 wrote:
> 
> Here's an example of what I'm trying to get at-- take 
> a node from a FSL device tree.  The ideas I've heard
> for expressing the class are like this--
> 
> #1  don't express any class at all:
> 
>   ucc@2200 {
>         compatible = "fsl,ucc_geth";
>         model = "UCC";
>         device-id = <3>;
>         reg = <2200 200>;
>         interrupts = <22>;
>         interrupt-parent = < &qeic >;
>         mac-address = [ 00 00 00 00 00 00 ];
>         local-mac-address = [ 00 00 00 00 00 00 ];
>         rx-clock = <19>;
>         tx-clock = <1a>;
>         phy-handle = < &phy3 >;
>         pio-handle = < &pio3 >;
>   
> 
>   > This is bad IMHO because the human reader has to
>   > infer the class of device.  Can the human reader
>   > tell if it implements a standardized binding or
>   > not??

Well... except that by the generic names convention, the node should
be called "ethernet@2200", which makes it rather clearer to a human
reader.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
