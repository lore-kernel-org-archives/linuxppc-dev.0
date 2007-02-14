Return-Path: <dgibson@ozlabs.org>
Date: Wed, 14 Feb 2007 11:31:19 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
Message-ID: <20070214003119.GF11491@localhost.localdomain>
References: <11713852392294-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <11713852392294-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Feb 13, 2007 at 10:47:19AM -0600, Timur Tabi wrote:
> The 'linux,boot-cpu' property and the 'chosen' node do not belong in the
> DTS file, because U-Boot creates these entries in the device tree when
> it boots linux.

[snip]
> @@ -53,13 +52,6 @@
>                 reg = <00000000 4000000 f4500000 00000020>;
>         };
>  
> -       chosen {
> -               name = "chosen";
> -               linux,platform = <0>;
> -               interrupt-controller = <10c00>;
> -               linux,phandle = <400>;
> -       };
> -

Um.. at least the interrupt-controller property here should be fixed,
and thus should probably remain in the dts.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
