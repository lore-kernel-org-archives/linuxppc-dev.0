Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Fix IO space on PCI busses created from
	of_platform
In-reply-to: <20070515062007.5A4B8DDEC4@ozlabs.org> 
References: <20070515062007.5A4B8DDEC4@ozlabs.org>
Date: Tue, 15 May 2007 16:37:44 +1000
Message-ID: <29203.1179211064@neuling.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -	/* Setup IO space.
> -	 * This will not work properly for ISA IOs, something needs to be done
> -	 * about it if we ever generalize that way of probing PCI brigdes
> +	/* Setup IO space. We use the non-dynamic version of that code here,
> +	 * which doesn't quite support unplugging. Next kernel release will
> +	 * have a better fix for this.
> +	 * Note also that we don't do ISA, this will also be fixed with a
> +	 * more massive rework.
>  	 */

Do you want to put some absolute kernel version numbers here (rather
than "next kernel release") so that someone reading this won't have to
look through the changelog to work out if this is an old bogus comment,
or something that is actively being hacked on?

Mikey
